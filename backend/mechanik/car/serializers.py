from rest_framework.serializers import ModelSerializer,ReadOnlyField


from car.models import Car,CarType,CarModel,CarBrand,CarBrandModel


class CarSerializer(ModelSerializer):

    owner = ReadOnlyField(source='owner.username')
    class Meta:
        model = Car
        fields = '__all__'

class CarTypeSerializer(ModelSerializer):

    class Meta:
        model = CarType
        fields = '__all__'

class CarModelSerializer(ModelSerializer):

    class Meta:
        model = CarModel
        fields = '__all__'

class CarBrandSerializer(ModelSerializer):

    class Meta:
        model = CarBrand
        fields = '__all__'
class CarBrandModelSerializer(ModelSerializer):

    class Meta:
        model = CarBrandModel
        fields = '__all__'


class CarTypeSerializer(ModelSerializer):

    class Meta:
        model = CarType
        fields = '__all__'



