from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import  generics
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from shop.models import Offer,Item,ItemBase,Category

from basetools.validator import validate_count
from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission
from shop.serializer import OfferSerializer,ItemBaseSerializer,\
    ItemSerializer,CategorySerializer
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
        count = validate_count(count)

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