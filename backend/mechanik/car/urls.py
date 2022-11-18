
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

urlpatterns = [
    path('',include(router.urls))
]
