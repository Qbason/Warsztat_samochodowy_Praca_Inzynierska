from userinfo import views
from django.urls import path, include
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(
    r'info',
    views.UserInfoViewSet,
    basename="info"
)
router.register(
    r'my',
    views.MyUserInfo,
    basename="my"
)


urlpatterns = [
    path('', include(router.urls)),
]