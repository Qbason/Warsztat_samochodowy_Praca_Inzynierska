
from car.models import CarModel,CarBrand,CarBrandModel,CarType,Car
from car.serializers import CarModelSerializer, CarBrandSerializer,\
    CarBrandModelSerializer, CarTypeSerializer, CarSerializer

from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from basetools.custompermissions import IsMechanicPermission

class CarModelViewSet(viewsets.ModelViewSet):
    queryset = CarModel.objects.all()
    serializer_class = CarModelSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CarBrandViewSet(viewsets.ModelViewSet):
    queryset = CarBrand.objects.all()
    serializer_class = CarBrandSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CarBrandModelViewSet(viewsets.ModelViewSet):
    queryset = CarBrandModel.objects.all()
    serializer_class = CarBrandModelSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]
    
class CarTypeViewSet(viewsets.ModelViewSet):
    queryset = CarType.objects.all()
    serializer_class = CarTypeSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CarViewSet(viewsets.ModelViewSet):
    queryset = Car.objects.all()
    serializer_class = CarSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


class MyCarsViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = CarSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):

        user = self.request.user

        my_cars = Car.objects.filter(
            owner=user.userinfo
        )

        # serializer = self.get_serializer(my_cars)


        return my_cars