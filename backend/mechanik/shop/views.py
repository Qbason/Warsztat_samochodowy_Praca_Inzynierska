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
        data receive
    """
    serializer_class = OfferReservationkSerializer
    queryset = Offer.objects.all()
    permission_classes = [IsAuthenticated]

    def check_number_of_reservation_general(self,user):

        if user.is_anonymous:
            raise PermissionDenied

        number_of_reservation = Item.objects.filter(
            reservation__client__user=user,
            reservation__was_taken=False
        ).distinct().count()

        return number_of_reservation



    def create(self,request,*args, **kwargs):

        
        serializer = OfferReservationkSerializer(data=request.data,context={'request':request})
        if not serializer.is_valid():
            return Response(
                serializer.errors
            )
        pk_offer = serializer.validated_data.get('pk')
        date_receive = serializer.validated_data.get('date_receive')

        result = {
            "result":"FAIL"
        }

        #checking the number of reservation (all products)
        number_of_reservation = self.check_number_of_reservation_general(request.user)
        if number_of_reservation>2:
            result['info']="Too much reservation products"
            return Response(
                result,
                status=status.HTTP_406_NOT_ACCEPTABLE
            )

        offer = self.get_queryset().filter(
            pk=pk_offer
        ).first()

        avail_items = Item.objects.filter(
            itembase = offer.itembase
        )
        if not avail_items:
            result['info'] = "All items has been reserved"
            return Response(
                result,
                status=status.HTTP_406_NOT_ACCEPTABLE
            )

        reservation = Reservation(
            client = request.user.userinfo,
            date_receive=date_receive
        )
        reservation.save()

        avail_items[0].reservation = reservation
        avail_items[0].save()

        result['result'] = "OK"
        result['info'] = "The item has been reserved"

        return Response(
            result
        )