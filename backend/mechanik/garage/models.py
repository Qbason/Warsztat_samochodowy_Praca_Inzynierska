from django.db import models
from userinfo.models import UserInfo
from datetime import datetime


#REVIEW
class Comment(models.Model):
    """
    Describe single review about garage
    """
    title = models.CharField(max_length=50)
    content = models.TextField()
    # for stars 1-5
    stars = models.PositiveSmallIntegerField(default=5)
    # when reviewed was added
    date_created = models.DateTimeField(auto_now_add=True)
    # who added the review
    author = models.OneToOneField(
        UserInfo,
        on_delete=models.CASCADE,
        primary_key=True
        )




class OpeningHours(models.Model):

    time_start = models.DateTimeField()
    time_end = models.DateTimeField()

    @staticmethod
    def default_openinghours():
        #default openinghours
        start = datetime.now().replace(minute=0,hour=8,second=0,microsecond=0)
        end = datetime.now().replace(minute=0,hour=17,second=0,microsecond=0)

        return (start.hour,end.hour)

    def __str__(self) -> str:
        return f"{self.time_start.hour}:{self.time_start.minute}-{self.time_end.hour}:{self.time_end.minute}"