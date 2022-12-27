from django.db import models
from django.conf import settings
from visit.models import Service, CarPlace

upload_to = settings.STATIC_URL[1:]

User = settings.AUTH_USER_MODEL 


#Event is special for mechanic calendar
class Event(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()

    #from time to time
    date_start = models.DateTimeField()
    date_end = models.DateTimeField()

    #mechanic can repair the client's car
    service = models.ForeignKey(
        Service,
        on_delete=models.SET_NULL,
        null=True
    )
    # which car place will be used
    carplace = models.ForeignKey(
        CarPlace,
        on_delete=models.SET_NULL,
        null=True
    )


