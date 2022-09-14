from statistics import quantiles
from unicodedata import category
from django.db import models

upload_to = "/mechanik/assets/"

# CLIENT CAR COMMENT(about client)
class Client(models.Model):
    name = models.CharField(max_length=30)
    surname = models.CharField(max_length=30)
    phone_number = models.CharField(max_length=30)

    roles = (
        ('M', 'Mechanic'),
        ('C', 'Client'),
    )

    role = models.CharField(choices=roles)

class Car(models.Model):
    Nr_VIN = models.CharField(max_length=20, primary_key=True)
    brand = models.CharField(max_length=30)
    model = models.CharField(max_length=30)
    type = models.CharField(max_length=30)
    client = models.ForeignKey(Client,on_delete=models.CASCADE)

class Comment(models.Model):
    content = models.TextField()
    date_created = models.DateTimeField(auto_now_add=True)
    author = models.ForeignKey(Client,on_delete=models.CASCADE)
    about_who = models.ForeignKey(Client,on_delete=models.CASCADE)
    
# REPAIRING

class Service(models.Model):
    name = models.CharField(max_length=100)


class Visit(models.Model):

    title = models.CharField(max_length=100)
    
    desc = models.TextField()

    date = models.DateTimeField()

    car = models.ForeignKey(
        Car,
        on_delete=models.CASCADE
    )


class Repair(models.Model):

    visit = models.ForeignKey(
        Visit,
        on_delete=models.CASCADE
    )
    name = models.ForeignKey(
        Service,
        on_delete=models.CASCADE
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
    condition = models.CharField(choices=condition_types)
    name = models.CharField(max_length=100)
    quantity = models.PositiveSmallIntegerField()
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE
    )

class Offer(models.Model):

    item = models.OneToOneField(
        Item,
        primary_key=True
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
        on_delete=models.CASCADE
    )

class Reservation(models.Model):
    klient = models.ForeignKey(Client,on_delete=models.CASCADE)
    offer = models.ForeignKey(Offer,on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    date_created = models.DateTimeField(auto_now_add=True)
    date_receive = models.DateTimeField()
    was_taken = models.BooleanField()

