from django.urls import path, include
from rest_framework.routers import DefaultRouter
from garage import views

router = DefaultRouter()

router.register(
    r'openinghourstoday',
    views.CheckOpeningHoursToday,
    basename="openinghourstoday"
)
router.register(
    'openinghours',
    views.OpeningHoursViewSet,
    basename="openinghours"
)

urlpatterns = [
        path('',include(router.urls))
]
