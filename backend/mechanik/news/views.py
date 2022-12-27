from news.models import News
from rest_framework import viewsets
from news.serializers import NewsSerializer
from rest_framework import generics
from basetools.schema import MyOwnSchema
from basetools.validator import validate_int
from basetools.custompermissions import IsMechanicPermission
from rest_framework.permissions import IsAuthenticated
from rest_framework import mixins

class NewsViewSet(viewsets.ModelViewSet):
    queryset = News.objects.all()
    serializer_class = NewsSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


class TheNewestNews(viewsets.GenericViewSet,mixins.ListModelMixin):
    """
    description:
        Return a list of news
        Length list is equal to "count" parameter
        News: title:str, content:str, image:str, date_created:datatime
    query:
        - count<->required<->
        - page<->

    """
    queryset = News.objects.all()
    serializer_class = NewsSerializer

    def get_queryset(self):
        count = self.request.GET.get("count")
        
        #raise error if is incorrect
        count = validate_int(count)

        queryset = self.queryset[:count]

        return queryset
