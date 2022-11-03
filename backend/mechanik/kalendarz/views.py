from rest_framework import viewsets
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated

from rest_framework.response import Response
from rest_framework.views import APIView

#model
from kalendarz.models import *
from kalendarz.serializers import *

from django.db.models import Count

from rest_framework.schemas import ManualSchema
import coreapi
import coreschema

from kalendarz.validators import validate_count

class NewsViewSet(viewsets.ModelViewSet):
    queryset = News.objects.all()
    serializer_class = NewsSerializer
    
class OfferViewSet(viewsets.ModelViewSet):
    queryset = Offer.objects.all()
    serializer_class = OfferSerializer

class ItemViewSet(viewsets.ModelViewSet):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer

class ItemBaseViewSet(viewsets.ModelViewSet):
    queryset = ItemBase.objects.all()
    serializer_class = ItemBaseSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class RepairViewSet(viewsets.ModelViewSet):
    queryset = Repair.objects.all()
    serializer_class = RepairSerializer

class VisitViewSet(viewsets.ModelViewSet):
    queryset = Visit.objects.all()
    serializer_class = VisitSerializer
class CarModelViewSet(viewsets.ModelViewSet):
    queryset = CarModel.objects.all()
    serializer_class = CarModelSerializer

class CarBrandViewSet(viewsets.ModelViewSet):
    queryset = CarBrand.objects.all()
    serializer_class = CarBrandSerializer

class CarBrandModelViewSet(viewsets.ModelViewSet):
    queryset = CarBrandModel.objects.all()
    serializer_class = CarBrandModelSerializer
    
class CarTypeViewSet(viewsets.ModelViewSet):
    queryset = CarType.objects.all()
    serializer_class = CarTypeSerializer

class CarViewSet(viewsets.ModelViewSet):
    queryset = Car.objects.all()
    serializer_class = CarSerializer

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user.userinfo)

class UserInfoViewSet(viewsets.ModelViewSet):
    queryset = UserInfo.objects.all()
    serializer_class = UserInfoSerializer

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)



class MyOwnSchema(ManualSchema):

    def __init__(self,description):

        # main_info="description"
        locations = ["path","query","form","body"]
        fields = []

        d1 = description.find("description:")+len("description:")
        d2 = description.find(":description")
        for location in locations:
            l1 = description.find(location+":")
            l2 = description.find(":"+location)
            if(l1!=-1 and l2!=-1):
                loc = description[l1+len(location)+1:l2]
                n1 = loc.find("- ")
                if n1==-1:
                    break
                n2 = loc.find("<->")
                if n2==-1:
                    break
                name = loc[n1+len("- "):n2]
                t = loc[n2+len("<->"):]
                t1 = t.find("<->")
                if t1==-1:
                    required = False
                else:
                    required = (t[:t1]=="required")
                fields.append(
                    coreapi.Field(
                        name,
                        required=required,
                        location=location,
                        schema=coreschema.String()
                    )
                )
        

        super().__init__(fields, description[d1:d2], "application/json")
class NewNewsList(APIView):


    def get(self,request,format=None):
        """
        description:
            Return a list of news
            Length list is equal to "count" parameter
            News: title:str, content:str, image:str, date_created:datatime
        :description
        query:
            - count<->required<->
        :query
        """
        count = request.GET.get("count")
        
        #raise error if is incorrect
        count = validate_count(count)

        queryset = News.objects.all()[:count]

        serializedqueryset = NewsSerializer(queryset,many=True,context={'request':request})

        return Response(serializedqueryset.data)
    

    schema = MyOwnSchema(description=get.__doc__,)


class NewOfferList(APIView):

    def get(self,request,format=None):
        """
        description:
            Return a list of offers
            Length list is equal to "count" parameter 
            Offer: title, description,price,image,date_created,itembase,quantity
        :description
        query:
            - count<->required<->
        :query
        """
        count = request.GET.get("count")
        #raise error if is incorrect
        count = validate_count(count)

        queryset = Offer.objects.filter(itembase__item__reservation=None).annotate(
            ile = Count('itembase__item')
        ).filter(ile__gt=0)[:count]

        serializedqueryset = OfferSerializer(queryset,many=True,context={'request':request})

        return Response(serializedqueryset.data)

    schema = MyOwnSchema(description=get.__doc__)



class YourReparingCars(APIView):

    def get(self,request,format=None):
        """
        description:
            Return a list of reparings
            Length list is equal to "count" parameter
            Repair: id_visit(can be null), list[id_services],cartaken(true/false)
        :description
        query:
            - count<->required<->
        :query
        """
        user = request.user

        repairs = Repair.objects.filter(
            visit__car__owner__user=user
        )
        repairs_serialized = RepairSerializer(repairs,many=True)

        print(user.userinfo)


        return Response(repairs_serialized.data)

    schema = MyOwnSchema(description=get.__doc__)