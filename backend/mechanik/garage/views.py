from garage.models import Comment,OpeningHours
from garage.serializers import CommentSerializer,OpeningHoursSerializer

from rest_framework import viewsets
from rest_framework.response import Response

import datetime



class CommentViewSet(viewsets.ModelViewSet):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer


class OpeningHoursViewSet(viewsets.ModelViewSet):
    queryset = OpeningHours.objects.all()
    serializer_class = OpeningHoursSerializer


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

