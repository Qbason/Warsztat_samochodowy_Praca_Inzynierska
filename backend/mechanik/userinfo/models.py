from django.db import models
from django.conf import settings


upload_to = settings.STATIC_URL[1:]

User = settings.AUTH_USER_MODEL # auth.User

# Auth code for password recovery

class GeneratedCode(models.Model):
    code = models.CharField(max_length=6)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    date_generated = models.DateTimeField(auto_now_add = True)
    date_expired = models.DateTimeField()
    confirmed = models.BooleanField(default=False)


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

    def __str__(self) -> str:
        return f"{self.name} {self.surname}"
