
from rest_framework.serializers import ModelSerializer
from visit.models import CarPlace,Service, ServiceName, Repair, VisitReason, VisitDescription,\
    Visit




class RepairClientSerializer(ModelSerializer):

    class Meta:
        model = Repair
        fields = ['pk',"visit","services","cartaken"]
        # depth = 1

class RepairSerializer(ModelSerializer):

    class Meta:
        model = Repair
        fields = ['pk',"visit","services","cartaken"]

class VisitReasonSerializer(ModelSerializer):

    class Meta:
        model = VisitReason
        fields = '__all__'

class VisitDescriptionSerializer(ModelSerializer):

    class Meta:
        model = VisitDescription
        fields = '__all__'

class VisitSerializer(ModelSerializer):

    class Meta:
        model = Visit
        fields = '__all__'

class VisitClientSerializer(ModelSerializer):

    class Meta:
        model = Visit
        fields = '__all__'
        depth=3


class ServiceSerializer(ModelSerializer):

    class Meta:
        model = Service
        fields = '__all__'
        read_only_fields = ['date_start','date_end','duration']

class ServiceClientSerializer(ModelSerializer):

    class Meta:
        model = Service
        fields = '__all__'
        read_only_fields = ['date_start','date_end','duration']
        depth = 1 

class ServiceNameSerializer(ModelSerializer):

    class Meta:
        model = ServiceName
        fields = '__all__'

class CarPlaceSerializer(ModelSerializer):

    class Meta:
        model = CarPlace
        fields = '__all__'