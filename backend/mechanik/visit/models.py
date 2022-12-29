from django.db import models
from django.conf import settings

upload_to = settings.STATIC_URL[1:]

from car.models import Car


#mechanic can have  many places where he can repairs cars
class CarPlace(models.Model):
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to=upload_to,null=True)


#more info about visit
class VisitDescription(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()

    def __str__(self) -> str:
        return f"{self.title} {self.content}"

class VisitReason(models.Model):
    reason = models.CharField(max_length=100,unique=True)
    #how much time does it need in minutes
    duration = models.PositiveSmallIntegerField(default=0)

    def __str__(self) -> str:
        return self.reason

# make an appointment to mechanic
class Visit(models.Model):

    #more info about the visit like AC doesn't work and makes noise
    visitdescription = models.ForeignKey(
        VisitDescription,
        on_delete=models.SET_NULL,
        null = True
    )

    #main reason, why we see client like diagnose, tires swap etc.
    visitreason = models.ForeignKey(
        VisitReason,
        on_delete=models.SET_NULL,
        null=True
    )

    #mechanic accepts visit or not
    is_accepted = models.BooleanField(default=False)

    #date and time, when client will arrive
    date_visit = models.DateTimeField()

    #estimated end visit (if it is possible) based on duration, but  can be changed by mechanic
    date_visit_end = models.DateTimeField(null=True)

    #date when the visited was created by user
    date_created_visit =  models.DateTimeField(auto_now_add=True)

    #which car he chose (car is assigned to client)
    car = models.ForeignKey(
        Car,
        on_delete=models.SET_NULL,null=True
    )
    
    #placecar
    carplace=models.ForeignKey(
            CarPlace,
            on_delete=models.SET_NULL,
            null=True
            )

    

# REPAIRING
class ServiceName(models.Model):
    # service name like: tires swap etc.
    name = models.CharField(max_length=100,unique=True)
    # usual price for this service
    price = models.DecimalField(decimal_places=2,max_digits=8,null=True)

    def __str__(self) -> str:
        return self.name

    
class Service(models.Model):
    #service name
    servicename = models.ForeignKey(ServiceName,on_delete=models.SET_NULL,null=True)
    #service price
    price = models.DecimalField(decimal_places=2,max_digits=8,null=True)
    #in which state is reparing 
    state = (
        ('T', 'Do zrobienia'),
        ('D', 'W trakcie'),
        ('DN', 'Zrobione')
    )
    progress = models.CharField(choices=state,max_length=20)
    #how much time does it consume
    date_start = models.DateTimeField(null=True)
    #adding to the event would increase the duration
    duration = models.SmallIntegerField(default=0)
    #monitoring when state is done then we got the date_end
    date_end = models.DateTimeField(null=True)

    def __str__(self) -> str:
        return f"{self.servicename} {self.price}zł"


class Repair(models.Model):

    # repair can be related to visit
    visit = models.ForeignKey(
        Visit,
        on_delete=models.SET_NULL,null=True
    )
    #which actions had been done
    services = models.ManyToManyField(
        Service
    )
    #car was taken
    cartaken = models.BooleanField(default=False)

