
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from car import views

router = DefaultRouter()

router.register(
    r'model',
    views.CarModelViewSet,
    basename="carmodel"
)
router.register(
    r'brand',
    views.CarBrandViewSet,
    basename="carbrand"
)
router.register(
    r'brandmodel',
    views.CarBrandModelViewSet,
    basename="brandmodel"
)
router.register(
    r'type',
    views.CarTypeViewSet,
    basename="type"
)
router.register(
    r'car',
    views.CarViewSet,
    basename="car"
)
router.register(
    r'mycars',
    views.MyCarsViewSet,
    basename="mycars"
)

urlpatterns = [
    path('',include(router.urls))
]
