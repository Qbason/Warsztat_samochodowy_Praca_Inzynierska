from django.db import models

# Create your models here.
#models.CharField(max_length=50)
#models.DateField()
#models.BooleanField
#models.IntegerField()
#models.PositiveIntegerField()
#models.TextField()
#id = models.BigAutoField(primary_key=True)
#models.OneToOneField(
#models.ManyToManyField

class Klienci(models.Model):
    ID_Klient = models.BigAutoField(primary_key=True)
    Imie = models.CharField(max_length=30)
    Nazwisko = models.CharField(max_length=30)
    Telefon = models.CharField(max_length=30)
    Nr_VIN_Samochodu = models.CharField(max_length=30)
    KomentarzMechanika = models.TextField()

class Kategorie(models.Model):
    ID_Kategorii = models.BigAutoField(primary_key=True)
    Nazwa_Kategorii = models.CharField(max_length=50)

class Newsy(models.Model):
    ID_Newsa = models.BigAutoField(primary_key=True)
    Tytul = models.CharField(max_length=30)
    Tresc = models.CharField(max_length=30)
    Zdjecie = models.CharField(max_length=200)
    Link = models.CharField(max_length=200)
    Data_Dodania = models.DateTimeField()

class Oferty(models.Model):
    STANY_TOWARU = (
        ('N', 'Nowy'),
        ('U', 'Używany'),
        ('Z', 'Zepsuty'),
    )
    ID_Oferty = models.BigAutoField(primary_key=True)
    ID_Towaru = models.PositiveIntegerField()
    Cena = models.PositiveBigIntegerField()
    Opis = models.TextField()
    Stan = models.CharField(max_length=1, choices=STANY_TOWARU)
    Zdjecie = models.CharField(max_length=200)

class Opinie(models.Model):
    ID_Opinii = models.BigAutoField(primary_key=True)
    Tresc_Opinii = models.TextField()
    Ilosc_Gwiazdek = models.PositiveIntegerField()
    Data_Wystawienia_Opinii = models.DateTimeField()

class Rezerwacje(models.Model):
    ID_Rezerwacji = models.BigAutoField(primary_key=True)
    ID_Klienta = models.PositiveIntegerField()
    ID_Oferty = models.PositiveBigIntegerField()
    Ilosc_Sztuk = models.PositiveIntegerField()
    Data_Rezerwacji = models.DateTimeField()
    Data_Ostateczna_Odbioru = models.DateTimeField()
    Czy_Odebrano = models.BooleanField()

class Samochody(models.Model):
    Nr_VIN = models.CharField(max_length=20, primary_key=True)
    Marka = models.CharField(max_length=30)
    Model = models.CharField(max_length=30)
    Typ_Pojazdu = models.CharField(max_length=30)
