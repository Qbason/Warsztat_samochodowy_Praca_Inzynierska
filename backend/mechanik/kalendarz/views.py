from rest_framework import viewsets
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated
from  rest_framework.exceptions  import ValidationError
from rest_framework.response import Response
from rest_framework.schemas.openapi import AutoSchema

#model
from kalendarz.models import News
from kalendarz.serializers import NewsSerializer
from rest_framework.views import APIView


from rest_framework.schemas import ManualSchema,DefaultSchema
from  rest_framework.schemas.openapi import AutoSchema


import coreapi

import coreschema

class NewsViewSet(viewsets.ModelViewSet):
    queryset = News.objects.all()
    serializer_class = NewsSerializer
    

class MyOwnSchema(ManualSchema):

    def __init__(self,description):

        # main_info="description"
        locations = ["path","query","form","body"]
        fields = []

        d1 = description.find("description:")+len("description:")
        d2 = description.find(":description")
        for location in locations:
            l1 = description.find(location+":")
            l2 = description.find(":"+location)
            if(l1!=-1 and l2!=-1):
                loc = description[l1+len(location)+1:l2]
                n1 = loc.find("- ")
                if n1==-1:
                    break
                n2 = loc.find("<->")
                if n2==-1:
                    break
                name = loc[n1+len("- "):n2]
                t = loc[n2+len("<->"):]
                t1 = t.find("<->")
                if t1==-1:
                    required = False
                else:
                    required = (t[:t1]=="required")
                fields.append(
                    coreapi.Field(
                        name,
                        required=required,
                        location=location,
                        schema=coreschema.String()
                    )
                )
        

        super().__init__(fields, description[d1:d2], "application/json")
class NewNewsList(APIView):


    def get(self,request,format=None):
        """
        description:
            Return a list of news
            Length list is equal to "count" parameter
            Return title:str, content:str, image:str, date_created:datatime
        :description
        query:
            - count<->required<->
        :query
        """
        count = request.GET.get("count")
        if count is None:
            raise ValidationError("Brak podanego parametru")
        try:
            count = int(count)
            if(count<=0):
                raise ValidationError("Wartość jest ujemna!")
        except:
            raise ValidationError("Wartośc nie jest liczbowa")
        
        queryset = News.objects.all()[:count]

        serializedqueryset = NewsSerializer(queryset,many=True,context={'request':request})

        return Response(serializedqueryset.data)
    

    schema = MyOwnSchema(description=get.__doc__,)