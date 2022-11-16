from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission


from visit.models import Service, ServiceName, Repair, VisitReason, VisitDescription,\
    Visit, CarPlace

from visit.serializers import ServiceSerializer, ServiceNameSerializer,\
    RepairSerializer,VisitReasonSerializer,VisitDescriptionSerializer,\
        VisitSerializer, CarPlaceSerializer


class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class ServiceNameViewSet(viewsets.ModelViewSet):
    queryset = ServiceName.objects.all()
    serializer_class = ServiceNameSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class RepairViewSet(viewsets.ModelViewSet):
    queryset = Repair.objects.all()
    serializer_class = RepairSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class VisitReasonViewSet(viewsets.ModelViewSet):
    queryset = VisitReason.objects.all()
    serializer_class = VisitReasonSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class VisitDescriptionViewSet(viewsets.ModelViewSet):
    queryset = VisitDescription.objects.all()
    serializer_class = VisitDescriptionSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class VisitViewSet(viewsets.ModelViewSet):
    queryset = Visit.objects.all()
    serializer_class = VisitSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]
    
class CarPlaceViewSet(viewsets.ModelViewSet):
    queryset = CarPlace.objects.all()
    serializer_class = CarPlaceSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


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
            - page<->notrequired<->
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


