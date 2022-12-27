from django.urls import path, include
from rest_framework.routers import DefaultRouter
from event import views

router = DefaultRouter()

router.register(
    r'event',
    views.EventViewSet,
    basename="event"
)

router.register(
    r'eventClient',
    views.EventClientViewSet,
    basename="eventClient"
)

urlpatterns = [
        path('',include(router.urls))
]
