from django.db import models
from userinfo.models import UserInfo
from django.conf import settings

upload_to = settings.STATIC_URL[1:]

#CAR 
class CarModel(models.Model):
    # model like corsa (brand-opel) etc.
    model = models.CharField(max_length=100)

    def __str__(self) -> str:
        return self.model

class CarBrand(models.Model):
    brand = models.CharField(max_length=100)

    def __str__(self) -> str:
        return self.brand

class CarBrandModel(models.Model):
    # brand like: BMW, AUDI etc.
    carbrand = models.ForeignKey(CarBrand,on_delete=models.SET_NULL,null=True)
    #carmodel - > ex. corsa
    carmodel = models.ForeignKey(CarModel,on_delete=models.SET_NULL,null=True) 

    def __str__(self) -> str:
        return f"{self.carbrand} {self.carmodel}"

class CarType(models.Model):
    # type like: car, truck, bus etc.
    type = models.CharField(max_length=50)

    def __str__(self) -> str:
        return self.type

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

    def __str__(self) -> str:
        return f"{self.Nr_VIN}\n{self.carbrandmodel}"