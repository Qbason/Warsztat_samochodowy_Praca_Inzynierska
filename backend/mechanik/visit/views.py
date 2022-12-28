from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from basetools.schema import MyOwnSchema
from basetools.custompermissions import IsMechanicPermission
from rest_framework import status,mixins

from visit.models import Service, ServiceName, Repair, VisitReason, VisitDescription,\
    Visit, CarPlace

from visit.serializers import ServiceSerializer, ServiceNameSerializer,\
    RepairSerializer,VisitReasonSerializer,VisitDescriptionSerializer,\
        VisitSerializer, CarPlaceSerializer, RepairClientSerializer


class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class ServiceClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    permission_classes = [IsAuthenticated]

##############
class ServiceNameViewSet(viewsets.ModelViewSet):
    queryset = ServiceName.objects.all()
    serializer_class = ServiceNameSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class ServiceNameClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = ServiceName.objects.all()
    serializer_class = ServiceNameSerializer
    permission_classes = [IsAuthenticated]
########
class RepairViewSet(viewsets.ModelViewSet):
    queryset = Repair.objects.all()
    serializer_class = RepairSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]
########
class VisitReasonViewSet(viewsets.ModelViewSet):
    queryset = VisitReason.objects.all()
    serializer_class = VisitReasonSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class VisitReasonClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = VisitReason.objects.all()
    serializer_class = VisitReasonSerializer
    permission_classes = [IsAuthenticated]
###########
class VisitDescriptionViewSet(viewsets.ModelViewSet):
    queryset = VisitDescription.objects.all()
    serializer_class = VisitDescriptionSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


class VisitDescriptionClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = VisitDescription.objects.all()
    serializer_class = VisitDescriptionSerializer
    permission_classes = [IsAuthenticated]


########
class VisitViewSet(viewsets.ModelViewSet):
    queryset = Visit.objects.all()
    serializer_class = VisitSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]
    
class VisitClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Visit.objects.all()
    serializer_class = VisitSerializer
    permission_classes = [IsAuthenticated]
    

#####
class CarPlaceViewSet(viewsets.ModelViewSet):
    queryset = CarPlace.objects.all()
    serializer_class = CarPlaceSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CarPlaceClientViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = CarPlace.objects.all()
    serializer_class = CarPlaceSerializer
    permission_classes = [IsAuthenticated]

#####
class YourReparingCars(viewsets.GenericViewSet,mixins.ListModelMixin):
    """
    description:
        Return a list of reparings
    """

    serializer_class = RepairClientSerializer
    permission_classes = [IsAuthenticated]


    def get_queryset(self):
        user = self.request.user

        repairs = Repair.objects.filter(
            visit__car__owner__user=user
        )

        return repairs



