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

router.register(
    'comment',
    views.CommentViewSet,
    basename="comment"
)

router.register(
    'commentClient',
    views.CommentClientViewSet,
    basename="commentClient"
)

urlpatterns = [
        path('',include(router.urls))
]
