from rest_framework.serializers import ModelSerializer,ReadOnlyField, Serializer
from rest_framework import serializers

from car.models import Car,CarType,CarModel,CarBrand,CarBrandModel


class CarSerializer(ModelSerializer):

    class Meta:
        model = Car
        fields = [
            "pk",
            "Nr_VIN",
            "carbrandmodel",
            "cartype",
            "owner",
            "photo"
        ]

class CarClientSerializer(ModelSerializer):

    class Meta:
        model = Car
        fields = [
            "pk",
            "Nr_VIN",
            "carbrandmodel",
            "cartype",
            "photo"
        ]
        depth=2

class CarTypeSerializer(ModelSerializer):

    class Meta:
        model = CarType
        fields = [
            "pk",
            "type"
        ]

class CarModelSerializer(ModelSerializer):

    class Meta:
        model = CarModel
        fields = [
            "pk",
            "model"
        ]

class CarBrandSerializer(ModelSerializer):

    class Meta:
        model = CarBrand
        fields = [
            "pk",
            "brand"
        ]

class CarBrandModelSerializer(ModelSerializer):

    class Meta:
        model = CarBrandModel
        fields = [
            "pk",
            "carbrand",
            "carmodel"
        ]





