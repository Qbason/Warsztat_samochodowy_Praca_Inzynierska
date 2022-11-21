
from rest_framework.serializers import ModelSerializer, ReadOnlyField
from rest_framework import serializers
from rest_framework.exceptions import ValidationError


from shop.models import Offer,ItemBase,Item,Category, Reservation

class OfferSerializer(ModelSerializer):

    quantity = ReadOnlyField()

    class Meta:
        model = Offer
        fields = '__all__'
        read_only_fields = [
            'date_created',
            'quantity'
        ]

class OfferReservationkSerializer(serializers.Serializer):
    #from offer
    pk = serializers.IntegerField(min_value=1)
    #from reservation
    date_receive = serializers.DateTimeField()

    def validate_pk(self,value):
        offer = Offer.objects.filter(
            pk=value
        ).first()
        print(
            self.context['request'].data.get('pk')
        )
        #checking if offer exist
        if not offer:
            raise ValidationError("This offer doesn't exist")
            
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