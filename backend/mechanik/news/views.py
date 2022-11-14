from news.models import News
from rest_framework import viewsets
from news.serializers import NewsSerializer
from rest_framework import generics
from basetools.schema import MyOwnSchema
from basetools.validator import validate_count
from basetools.custompermissions import IsMechanicPermission
from rest_framework.permissions import IsAuthenticated

class NewsViewSet(viewsets.ModelViewSet):
    queryset = News.objects.all()
    serializer_class = NewsSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]


class NewNewsList(generics.ListAPIView):

    queryset = News.objects.all()
    serializer_class = NewsSerializer

    def get_queryset(self):
        count = self.request.GET.get("count")
        
        #raise error if is incorrect
        count = validate_count(count)

        queryset = self.queryset[:count]

        return queryset

    def get(self,*args, **kwargs):
        """
        description:
            Return a list of news
            Length list is equal to "count" parameter
            News: title:str, content:str, image:str, date_created:datatime
        :description
        query:
            - count<->required<->
            - page<->
        :query
        """
        

        return super().get(*args,**kwargs)

    schema = MyOwnSchema(description=get.__doc__,)