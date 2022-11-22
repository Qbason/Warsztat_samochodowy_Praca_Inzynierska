
from rest_framework.serializers import ModelSerializer, ReadOnlyField
from rest_framework import serializers
from rest_framework.exceptions import ValidationError
from rest_framework import status

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
        
        #checking if user doesn't have more than 2 rezervation of different products 
        user = self.context['request'].user
        number_of_reservation = Item.objects.filter(
            reservation__client__user=user,
            reservation__was_taken=False
        ).distinct().count()
        if number_of_reservation>2:
            raise ValidationError("User has more than 2 reservation active",code=status.HTTP_406_NOT_ACCEPTABLE)


        return value


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

class ReservationSerializer(ModelSerializer):

    class Meta:
        model = Reservation
        fields = '__all__'