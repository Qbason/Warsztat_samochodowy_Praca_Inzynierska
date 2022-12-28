from garage.models import Comment,OpeningHours
from garage.serializers import *

from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from basetools.custompermissions import IsMechanicPermission
from rest_framework import mixins



import datetime



class CommentClientViewSet(viewsets.ModelViewSet):

    serializer_class = CommentClientSerializer 
    queryset = Comment.objects.all()
    

    def perform_create(self, serializer):
        serializer.save(author=self.request.user.userinfo)

class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class OpeningHoursViewSet(viewsets.ModelViewSet):
    queryset = OpeningHours.objects.all()
    serializer_class = OpeningHoursSerializer
    permission_classes = [IsAuthenticated,IsMechanicPermission]

class CheckOpeningHoursToday(viewsets.GenericViewSet):

    def list(self, request, *args, **kwargs):

        oh = OpeningHours.objects.filter(
            time_start__day=datetime.datetime.now().day
        ).first()
        
        if oh:
            response = {
                "open":oh.time_start.hour,
                "close":oh.time_end.hour
            }
            return Response(response)

        doh = OpeningHours.default_openinghours()
        response = {
            "open":doh[0],
            "close":doh[1],
        }
        return Response(response)

