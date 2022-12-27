
from rest_framework.serializers import ModelSerializer, ReadOnlyField
from rest_framework import serializers
from rest_framework import serializers
from rest_framework.exceptions import ValidationError
from rest_framework import status
from django.db.models import Count

from shop.models import Offer,ItemBase,Item,Category, Reservation



class OfferSerializer(ModelSerializer):

    quantity = ReadOnlyField()
    pk = ReadOnlyField()
    
    class Meta:
        model = Offer
        fields = [
            'pk',
            'itembase',
            'quantity',
            'title',
            'description',
            'price',
            'image',
            'hide',
            'date_created'
        ]
        read_only_fields = [
            'date_created',
            'quantity'
        ]

class OfferNoHideSerializer(ModelSerializer):

    quantity = ReadOnlyField()
    pk = ReadOnlyField()
    
    class Meta:
        model = Offer
        fields = [
            'pk',
            'itembase',
            'quantity',
            'title',
            'description',
            'price',
            'image',
            'date_created'
        ]
        read_only_fields = [
            'date_created',
            'quantity'
        ]

class OfferCancelReservationSerializer(serializers.Serializer):
    #from offer
    pk = serializers.IntegerField(min_value=1)
    # number of products
    number = serializers.IntegerField(min_value=1)

    def validate_pk(self, value):

        offer = Offer.objects.filter(
            pk=value,
        )
        if not offer.count()>0:
            raise ValidationError("You can't cancel not existing offer")

        return value



class OfferReservationkSerializer(serializers.Serializer):
    #from offer
    pk = serializers.IntegerField(min_value=1)
    # nubmer
    number = serializers.IntegerField(min_value=1)

    def validate_pk(self,value):
        offer = Offer.objects.filter(
            pk=value,
            hide=False
        ).first()
        #checking if offer exist
        if not offer:
            raise ValidationError("This offer doesn't exist",code=status.HTTP_406_NOT_ACCEPTABLE)

        return value


class ItemBaseSerializer(ModelSerializer):

    class Meta:
        model = ItemBase
        fields = ['pk','name','condition','category','price']

class ItemBaseClientSerializer(ModelSerializer):

    class Meta:
        model = ItemBase
        fields = ['pk','name','condition','category']

class ItemSerializer(ModelSerializer):

    class Meta:
        model = Item
        fields = ['pk','itembase','reservation']

class CategorySerializer(ModelSerializer):
    
    class Meta:
        model = Category
        fields = ['pk','name']

class ReservationSerializer(ModelSerializer):

    class Meta:
        model = Reservation
        fields = '__all__'

    
class OfferByCategorySerializer(serializers.Serializer):

    pk=serializers.IntegerField(min_value=1)

    def validate_pk(self, value):
        
        if not Category.objects.filter(pk=value).first():
            raise ValidationError(
                "This category doesn't exist"
            )

        return value


class OfferReservedSerializer(ModelSerializer):

    reserved_number=serializers.IntegerField()

    pk = ReadOnlyField()
    
    class Meta:
        model = Offer
        fields = [
            'pk',
            'itembase',
            'title',
            'description',
            'price',
            'image',
            'date_created',
            'reserved_number'
        ]
        read_only_fields = [
            'date_created',
        ]


class AddNewItemBaseAndQuantity(serializers.ModelSerializer):

    quantity = serializers.IntegerField(min_value=1,write_only=True)

    class Meta:
        model = ItemBase
        fields = ['pk','name','condition','category','price','quantity']

    def create(self, validated_data):

        quantity = validated_data.pop('quantity')

        itembase = ItemBase.objects.create(**validated_data)

        for i in range(0,quantity):

            Item.objects.create(itembase=itembase,reservation=None)


        return itembase