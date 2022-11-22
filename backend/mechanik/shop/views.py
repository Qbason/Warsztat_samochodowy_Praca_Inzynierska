from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import  generics
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from rest_framework.exceptions import PermissionDenied
from rest_framework import status

from shop.models import Offer,Item,ItemBase,Category, Reservation

from basetools.validator import validate_int
from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission
from shop.serializer import OfferSerializer,ItemBaseSerializer,\
    ItemSerializer,CategorySerializer, ReservationSerializer, OfferReservationkSerializer
from django.db.models import Count


class OfferViewSet(viewsets.ModelViewSet):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class TheNewestOffers(generics.ListAPIView):

    queryset = Offer.objects.all()
    serializer_class = OfferSerializer

    def get_queryset(self):
        count = self.request.GET.get("count")
        
        #raise error if is incorrect
        count = validate_int(count)

        queryset = Offer.objects.filter(itembase__item__reservation=None).annotate(
            ile = Count('itembase__item')
        ).filter(ile__gt=0)[:count]

        return queryset

    def get(self,*args, **kwargs):
        """
        description:
            Return a list of offers
            Length list is equal to "count" parameter 
            Offer: title, description,price,image,date_created,itembase,quantity
        :description
        query:
            - count<->required<->
            - page<->notrequired<->
        :query
        """
        return super().get(*args, **kwargs)

    schema = MyOwnSchema(description=get.__doc__)



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


class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Reservation.objects.all()
    serializer_class = ReservationSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]



class MakeReservationOffer(viewsets.GenericViewSet):
    """
    Creating new reservation and assign it to item
    Need:
        pk(offer)
        Number of products
    """
    serializer_class = OfferReservationkSerializer
    queryset = Offer.objects.all()
    permission_classes = [IsAuthenticated]


    def create(self,request,*args, **kwargs):

        serializer = OfferReservationkSerializer(data=request.data,context={'request':request})
        if not serializer.is_valid():
            return Response(
                serializer.errors,
                status.HTTP_400_BAD_REQUEST
            )
        pk_offer = serializer.validated_data.get('pk')
        number = int(serializer.validated_data.get('number'))

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
            result['info'] = "All items has been reserved"
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