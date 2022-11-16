from django.urls import path, include
from rest_framework.routers import DefaultRouter

from visit import views

router = DefaultRouter()

router.register(
    r'service',
    views.ServiceViewSet,
    'service'
)
router.register(
    r'servicename',
    views.ServiceNameViewSet,
    'servicename'
)
router.register(
    r'repair',
    views.RepairViewSet,
    'repair'
)
router.register(
    r'visitreason',
    views.VisitReasonViewSet,
    'visitreason'
)
router.register(
    r'visit',
    views.VisitViewSet,
    'visit'
)


urlpatterns = [
    path('yourreparingcars/',views.YourReparingCars.as_view()),
    path('',include(router.urls))
]
