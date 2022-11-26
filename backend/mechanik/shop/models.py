from django.db import models
from django.conf import settings
from userinfo.models import UserInfo


upload_to = settings.STATIC_URL[1:]

User = settings.AUTH_USER_MODEL 


# SHOP

class Reservation(models.Model):
    client = models.ForeignKey(UserInfo,on_delete=models.SET_NULL,null=True)
    date_created = models.DateTimeField(auto_now_add=True)
    # timem, when mechanic give the item to the customer
    date_receive = models.DateTimeField(null=True)
    was_taken = models.BooleanField(default=False)

    def __str__(self) -> str:
        return f'{self.pk}'

class Category(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self) -> str:
        return f'{self.name}'


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

    def __str__(self) -> str:
        return self.name

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

    def __str__(self) -> str:
        return f"Pk(item):{self.pk}\nPk(itembase):{self.itembase.pk}\
    \nName(itembase):{self.itembase.name} Res:{self.reservation}##"

# class CanceledReservation(models.Model):
#     reservation = models.OneToOneField(Reservation,on_delete=models.CASCADE)
#     itembase = models.ForeignKey(
#         ItemBase,
#         on_delete=models.SET_NULL,
#         null=True
#     )
    



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
        ItemBase,
        primary_key=True,
        on_delete=models.PROTECT
    )
    # possibility to hide
    hide = models.BooleanField(default=False)
    # when the  offer was created
    date_created = models.DateTimeField(auto_now_add=True)

    #quantity
    @property
    def quantity(self):
        return self.itembase.item_set.filter(reservation=None).count()
        # return Item.objects.filter(itembase=self.itembase,reservation=None).count()

    class Meta:
        ordering = ["-date_created"]

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
