from datetime import datetime
from email.policy import default
from django.db import models
from django.conf import settings

upload_to = settings.STATIC_URL[1:]

User = settings.AUTH_USER_MODEL # auth.User

class UserInfo(models.Model):

    #user
    user = models.OneToOneField(User,primary_key=True,on_delete=models.PROTECT)
    # user name
    name = models.CharField(max_length=30)
    # user surname
    surname = models.CharField(max_length=30)
    # user's phone number
    phone_number = models.CharField(max_length=30)
    #user's email
    email = models.EmailField(max_length=100)
    #avatar
    avatar = models.ImageField(upload_to=upload_to,default="default-avatar.jpg")

    # user role -> mechanic or client
    roles = (
        ('M', 'Mechanic'),
        ('C', 'Client'),
    )

    role = models.CharField(choices=roles,max_length=100)


#CAR 
class CarModel(models.Model):
    # model like corsa (brand-opel) etc.
    model = models.CharField(max_length=100)

class CarBrand(models.Model):
    brand = models.CharField(max_length=100)

class CarBrandModel(models.Model):
    # brand like: BMW, AUDI etc.
    carbrand = models.ForeignKey(CarBrand,on_delete=models.SET_NULL,null=True)
    #carmodel - > ex. corsa
    carmodel = models.ForeignKey(CarModel,on_delete=models.SET_NULL,null=True) 

class CarType(models.Model):
    # type like: car, truck, bus etc.
    type = models.CharField(max_length=50)

class Car(models.Model):
    """
    Descibe single car
    """
    Nr_VIN = models.CharField(max_length=20, unique=True)
    #car-> brand and model -> special for unique choose
    carbrandmodel = models.ForeignKey(CarBrandModel,on_delete=models.SET_NULL,null=True)
    #type like car, truck, bus etc.
    cartype = models.ForeignKey(CarType,on_delete=models.SET_NULL,null=True)
    # owner
    owner = models.ForeignKey(UserInfo,on_delete=models.SET_NULL,null=True)
    # photo
    photo = models.ImageField(upload_to = upload_to, null = True)

    
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
    # who adddes the review
    author = models.ForeignKey(UserInfo,on_delete=models.SET_NULL,null=True)



#mechanic can have  many places where he can repairs cars
class CarPlace(models.Model):
    name = models.CharField(max_length=100)
    image = models.ImageField(upload_to=upload_to,null=True)


#more info about visit
class VisitDescription(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()

class VisitReason(models.Model):
    reason = models.CharField(max_length=100,unique=True)
    #how much time does it need in minutes
    duration = models.PositiveSmallIntegerField(default=0)

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
    date_start = models.DateTimeField(auto_now_add=True)
    #adding to the event would increase the duration
    duration = models.SmallIntegerField(default=0)
    #monitoring when state is done then we got the date_end
    date_end = models.DateTimeField()
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



# MAIN PAGE
class News(models.Model):
    title = models.CharField(max_length=30,help_text="Title")
    content = models.TextField()
    image = models.ImageField(
        upload_to = upload_to,
        null = True,
        help_text="Full url news"
    )
    date_created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-date_created"]



# SHOP
class Reservation(models.Model):
    client = models.ForeignKey(UserInfo,on_delete=models.SET_NULL,null=True)
    date_created = models.DateTimeField(auto_now_add=True)
    date_receive = models.DateTimeField()
    was_taken = models.BooleanField()

class Category(models.Model):
    name = models.CharField(max_length=50)


class ItemBase(models.Model):
    name = models.CharField(max_length=100)
    condition_types = (
        ('N', 'New'),
        ('U', 'Used'),
        ('D', 'Damaged'),
    )
    condition = models.CharField(choices=condition_types,max_length=10)
    category = models.ForeignKey(
        Category,
        on_delete=models.PROTECT
    )
    #purchase price (mechanic)
    price = models.DecimalField(max_digits=8,decimal_places=2)

# special for quantity items
class Item(models.Model):
    itembase = models.ForeignKey(
        ItemBase,
        on_delete=models.SET_NULL,null=True
    )
    #item can be assigned to specific reservation
    reservation = models.ForeignKey(
        Reservation,
        on_delete=models.SET_NULL,
        null=True
    )

class Offer(models.Model):

    #title offfer
    title = models.CharField(max_length=100)
    #description about the offfer
    description = models.TextField()
    #purchase price for client
    price = models.DecimalField(max_digits=8,decimal_places=2)
    #image
    image = models.ImageField(
        upload_to = upload_to,
        null = True
    )
    #which item is being sold
    itembase = models.OneToOneField(
        Item,
        primary_key=True,
        on_delete=models.PROTECT
    )

    #quantity
    @property
    def quantity(self):
        return Item.objects.filter(itembase=self.itembase,reservation=None).count()

#opinion about the product
class Opinion(models.Model):
    title = models.CharField(max_length=100)
    content = models.TextField()
    number_of_stars = models.PositiveIntegerField()
    date_created = models.DateTimeField()
    offer = models.ForeignKey(
        Offer,
        on_delete=models.SET_NULL,null=True
    )


class OpeningHours(models.Model):

    time_start = models.DateTimeField()
    time_end = models.DateTimeField()

    @staticmethod
    def default_openinghours():
        #default openinghours
        start = datetime.now().replace(minute=0,hour=8,second=0,microsecond=0)
        end = datetime.now().replace(minute=0,hour=17,second=0,microsecond=0)

        return (start,end)