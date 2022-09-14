
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from .models import News

class NewsWebPageSerializer(ModelSerializer):

    class Meta:
        model = News
        fields = ['title','content','image','date_created']