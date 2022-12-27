from userinfo import views
from django.urls import path, include
from rest_framework.routers import DefaultRouter

router = DefaultRouter()
router.register(
    r'',
    views.UserInfoViewSet,
    basename="info"
)


urlpatterns = [
    path('my/',views.MyUserInfo.as_view()),
    path('', include(router.urls)),
]