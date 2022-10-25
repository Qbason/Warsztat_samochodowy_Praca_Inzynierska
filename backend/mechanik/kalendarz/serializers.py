
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from .models import Category, ItemBase, Item, News, Offer

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