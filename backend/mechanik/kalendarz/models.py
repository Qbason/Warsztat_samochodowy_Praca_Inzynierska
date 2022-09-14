

from django.db import models
from django.conf import settings

upload_to = settings.STATIC_URL[1:]


# CLIENT CAR COMMENT(about client)
class Client(models.Model):
    name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30)
    phone_number = models.CharField(max_length=30)

    roles = (
        ('M', 'Mechanic'),
        ('C', 'Client'),
    )

    role = models.CharField(choices=roles,max_length=1)

class Car(models.Model):
    Nr_VIN = models.CharField(max_length=20, primary_key=True)
    brand = models.CharField(max_length=30)
    model = models.CharField(max_length=30)
    type = models.CharField(max_length=30)
    client = models.ForeignKey(Client,on_delete=models.CASCADE,
    related_name="Car_Client"
    )

class Comment(models.Model):
    content = models.TextField()
    date_created = models.DateTimeField(auto_now_add=True)
    author = models.ForeignKey(Client,on_delete=models.CASCADE,
        related_name="Comment_Client_Author"
        )
    about_who = models.ForeignKey(Client,on_delete=models.CASCADE,
        related_name="Comment_Client_About_Who")
    
# REPAIRING

class Service(models.Model):
    name = models.CharField(max_length=100)


class Visit(models.Model):

    title = models.CharField(max_length=100)
    
    desc = models.TextField()

    date = models.DateTimeField()

    car = models.ForeignKey(
        Car,
        on_delete=models.CASCADE,
            related_name="Visit_Car"
    )


class Repair(models.Model):

    visit = models.ForeignKey(
        Visit,
        on_delete=models.CASCADE,
            related_name="Repair_Visit"
    )
    name = models.ForeignKey(
        Service,
        on_delete=models.CASCADE,
            related_name="Repair_Service"
    )
    price = models.FloatField()


# MAIN PAGE
class News(models.Model):
    title = models.CharField(max_length=30)
    content = models.CharField(max_length=30)
    image = models.ImageField(
        upload_to = upload_to,
        null = True
    )
    date_created = models.DateTimeField(auto_now_add=True)



# SHOP
class Category(models.Model):
    name = models.CharField(max_length=50)
class Item(models.Model):
    condition_types = (
        ('N', 'New'),
        ('U', 'Used'),
        ('D', 'Damaged'),
    )
    condition = models.CharField(choices=condition_types,max_length=1)
    name = models.CharField(max_length=100)
    quantity = models.PositiveSmallIntegerField()
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE,
            related_name="Item_Category"
    )

class Offer(models.Model):

    item = models.OneToOneField(
        Item,
        primary_key=True,
        on_delete=models.CASCADE,
            related_name="Offer_Item"
    )
    price = models.PositiveBigIntegerField()
    description = models.TextField()
    image = models.ImageField(
        upload_to = upload_to,
        null = True
    )


class Opinion(models.Model):
    content = models.TextField()
    number_of_stars = models.PositiveIntegerField()
    date_created = models.DateTimeField()
    offer = models.ForeignKey(
        Offer,
        on_delete=models.CASCADE,
            related_name="Opinion_Offer"
    )

class Reservation(models.Model):
    klient = models.ForeignKey(Client,on_delete=models.CASCADE,
        related_name="Resevation_Cleint")
    offer = models.ForeignKey(Offer,on_delete=models.CASCADE,
        related_name="Reservation_Offer")
    quantity = models.PositiveIntegerField()
    date_created = models.DateTimeField(auto_now_add=True)
    date_receive = models.DateTimeField()
    was_taken = models.BooleanField()

