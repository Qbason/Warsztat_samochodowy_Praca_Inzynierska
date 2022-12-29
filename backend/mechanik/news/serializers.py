from  news.models import News
from rest_framework.serializers import ModelSerializer

class NewsSerializer(ModelSerializer):

    class Meta:
        model = News
        fields = ['id','title','content','image','date_created']
