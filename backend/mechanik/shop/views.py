from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import  generics
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.exceptions import PermissionDenied
from rest_framework import status,mixins
from rest_framework.validators import ValidationError
from shop.models import Offer,Item,ItemBase,Category, Reservation
from basetools.validator import validate_int
from basetools.serializers import CountSerializer
from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission
from shop.serializer import *
from django.db.models import Count


class OfferViewSet(viewsets.ModelViewSet):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

    
class OfferSearchByTitleViewSet(viewsets.GenericViewSet,mixins.ListModelMixin):
    """
    We need:
        * title
    """
    serializer_class = OfferNoHideSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = Offer.objects.all()
        title = self.request.query_params.get('title')
        if not title:
            raise ValidationError(
                {"title":"Need title"}
            )
        queryset = queryset.filter(title__icontains=title).all()
        
        return queryset

class TheNewestOffers(viewsets.GenericViewSet,mixins.ListModelMixin):
    """
    description:
        Return a list of offers
        Length list is equal to "count" parameter 
        Offer: title, description,price,image,date_created,itembase,quantity
    query:
        - count<->required<->
        - page<->notrequired<->
    """
    queryset = Offer.objects.all()
    serializer_class = OfferNoHideSerializer

    def get_queryset(self):
        data = self.request.GET

        serializer = CountSerializer(data=data,context={'request':self.request})

        if not serializer.is_valid():
            raise ValidationError(
                detail=serializer.errors
            )

        queryset = Offer.objects.filter(itembase__item__reservation=None).annotate(
            ile = Count('itembase__item')
        ).filter(ile__gt=0)[:serializer.validated_data.get('count')]

        return queryset
    


    
class MyReservedItems(viewsets.GenericViewSet):

    queryset = Item.objects.all()
    serializer_class = ItemSerializer
    permission_classes = [IsAuthenticated]

    def list(self,request,*args, **kwargs):

        user = request.user

        offer = Offer.objects.filter(
            itembase__item__reservation__client=user.userinfo,
            itembase__item__reservation__was_taken=False,
        ).annotate(reserved_number=Count('itembase'))

        serialized_offer = OfferReservedSerializer(offer,context={'request':request},many=True)

        return Response(serialized_offer.data)


class ItemBaseForClientViewSet(viewsets.ReadOnlyModelViewSet):
    # queryset = Item.objects.all()
    serializer_class = ItemBaseClientSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):

        #need fix to show itembase hidden if user has reserved this item
        return ItemBase.objects.filter(
            offer__isnull=False,
            offer__hide = False,
        ).all()
        
    

class ItemViewSet(viewsets.ModelViewSet):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]



class ItemBaseViewSet(viewsets.ModelViewSet):
    queryset = ItemBase.objects.all()
    serializer_class = ItemBaseSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

    
class OfferByCategory(viewsets.GenericViewSet,mixins.ListModelMixin):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        data = self.request.GET
        serializer = OfferByCategorySerializer(data=data)

        if not serializer.is_valid():
            raise ValidationError(
                detail = serializer.errors
            )
        #pk category
        pk = serializer.validated_data.get('pk')


        obj = Offer.objects.filter(
            itembase__category__pk=pk
        ).all()

        return obj



    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)


class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Reservation.objects.all()
    serializer_class = ReservationSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


class CancelReservationOffer(viewsets.GenericViewSet,mixins.DestroyModelMixin):

    serializer_class = OfferCancelReservationSerializer
    queryset = Offer.objects.all()
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):

        serializer = OfferCancelReservationSerializer(
            data=request.data,
            context={'request':request}
        )
        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status.HTTP_400_BAD_REQUEST
            )

        result = {
            "result":"FAIL"
        }


        #pk
        pk = serializer.validated_data.get("pk")
        #number
        number = serializer.validated_data.get("number")
        #user
        user = request.user
        
        items = Item.objects.filter(
            reservation__client = user.userinfo,
            itembase__offer__pk = pk,
            reservation__was_taken=False
            #hide=True, if someone reserved smth, which is not available now
        )
        reservation = items.first().reservation


        diff_offer_number = items.count()-number

        if diff_offer_number<0:
            result['info'] = "You don't have enough items reserved"
            return Response(
                result,
                status=status.HTTP_406_NOT_ACCEPTABLE
            )
        
        to_delete_reservation_itme_pk = items.all()[:number].values_list('pk')
        Item.objects.filter(pk__in=to_delete_reservation_itme_pk).update(reservation=None)
        if Item.objects.filter(reservation=reservation).count()==0:
            reservation.delete()


        result['result'] = "OK"
        result['info']="Reservation cancelation successful"




        return Response(result)


class MakeReservationOffer(viewsets.GenericViewSet):
    """
    Creating new reservation and assign it to item, need:
        * pk(offer)
        * Number of products(number)
    """
    serializer_class = OfferReservationkSerializer
    queryset = Offer.objects.all()
    permission_classes = [IsAuthenticated]


    def group_by_reserved_items_by_user(self,user):
        return ItemBase.objects.filter(
            item__reservation__client__user=user,
            item__reservation__was_taken=False
        ).annotate(Count('pk'))

    def check_if_user_has_too_much_different_reservation(self,itembases_filtered_groupby_count,pk_offer):
        #if user has  more or equal than 2 different reeservation  
        if itembases_filtered_groupby_count.count()>=2:
            #the pk of offer->itembase is in grouped elements
            #if there exists then, we can make this reservation
            # we can buy more item, we already reserved
            for itembase in itembases_filtered_groupby_count:
                if itembase.offer.pk==pk_offer:
                    return False
            return True


    def create(self,request,*args, **kwargs):

        serializer = OfferReservationkSerializer(data=request.data,context={'request':request})
        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status.HTTP_400_BAD_REQUEST
            )
        pk_offer = serializer.validated_data.get('pk')
        number = int(serializer.validated_data.get('number'))

        #checking if user doesn't have more than 2 rezervation of different products 
        user = self.request.user
        itembases_filtered = self.group_by_reserved_items_by_user(user)
        decision = self.check_if_user_has_too_much_different_reservation(itembases_filtered,pk_offer)
        #otherwise we can't make order
        if decision:
            raise ValidationError({"pk":"User has atleast 2 reservation active"},code=status.HTTP_406_NOT_ACCEPTABLE)
    
        result = {
            "result":"FAIL"
        }

        #checking has much items are in database
        avail_items = Item.objects.filter(
            itembase__offer__pk=pk_offer, #offer.itembase
            reservation=None
        )

        #checking if we have enough products
        if avail_items.count()<number:
            result['info'] = "All items already has been reserved"
            return Response(
                result,
                status=status.HTTP_406_NOT_ACCEPTABLE
            )
        # create reservation
        reservation = Reservation(
            client = request.user.userinfo
        )
        reservation.save()
        
        # assign reservation to items
        Item.objects.filter(
            pk__in=list(element.pk for element in avail_items[:number])
        ).update(
            reservation=reservation
        )

        result['result'] = "OK"
        result['info'] = "The item has been reserved"

        return Response(
            result
        )