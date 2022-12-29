from rest_framework import serializers


class CountSerializer(serializers.Serializer):

    count = serializers.IntegerField(min_value=1)
