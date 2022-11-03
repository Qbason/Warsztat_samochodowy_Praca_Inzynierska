
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from .models import *

class NewsSerializer(ModelSerializer):

    class Meta:
        model = News
        fields = ['id','title','content','image','date_created']

class OfferSerializer(ModelSerializer):

    class Meta:
        model = Offer
        fields = ['title','description','price','image','date_created','itembase','quantity']

class ItemBaseSerializer(ModelSerializer):

    class Meta:
        model = ItemBase
        fields = ['pk','name','condition','category','price']

class ItemSerializer(ModelSerializer):

    class Meta:
        model = Item
        fields = ['pk','itembase','reservation']

class CategorySerializer(ModelSerializer):
    
    class Meta:
        model = Category
        fields = ['pk','name']


class RepairSerializer(ModelSerializer):

    class Meta:
        model = Repair
        fields = ['pk',"visit","services","cartaken"]

class VisitSerializer(ModelSerializer):

    class Meta:
        model = Visit
        fields = '__all__'


class CarSerializer(ModelSerializer):

    owner = serializers.ReadOnlyField(source='owner.username')
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



class ServiceSerializer(ModelSerializer):

    class Meta:
        model = Service
        fields = '__all__'


class CarTypeSerializer(ModelSerializer):

    class Meta:
        model = CarType
        fields = '__all__'

class UserInfoSerializer(ModelSerializer):

    user = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = UserInfo
        fields = '__all__'

