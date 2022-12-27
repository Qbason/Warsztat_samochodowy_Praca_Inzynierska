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
    r'serviceClient',
    views.ServiceClientViewSet,
    'serviceClient'
)
router.register(
    r'servicename',
    views.ServiceNameViewSet,
    'servicename'
)
router.register(
    r'servicenameClient',
    views.ServiceNameClientViewSet,
    'servicenameClient'
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
    r'visitreasonClient',
    views.VisitReasonClientViewSet,
    'visitreasonClient'
)
router.register(
    r'visitdescription',
    views.VisitDescriptionViewSet,
    'visitdescription'
)
router.register(
    r'visitdescriptionClient',
    views.VisitDescriptionClientViewSet,
    'visitdescriptionClient'
)
router.register(
    r'visit',
    views.VisitViewSet,
    'visit'
)
router.register(
    r'visitClient',
    views.VisitClientViewSet,
    'visitClient'
)
router.register(
    r'carplace',
    views.CarPlaceViewSet,
    'carplace'
)
router.register(
    r'carplaceClient',
    views.CarPlaceClientViewSet,
    'carplaceClient'
)
router.register(
    r'yourreparingcars',
    views.YourReparingCars,
    'yourreparingcars'
)


urlpatterns = [
    path('',include(router.urls))
]
