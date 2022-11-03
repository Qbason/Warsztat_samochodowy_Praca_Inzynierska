from kalendarz import views
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.conf.urls.static import static
from django.conf import settings

from rest_framework.authentication import BasicAuthentication


from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

from rest_framework.documentation import include_docs_urls

router = DefaultRouter()

router.register(
    r'news',
    views.NewsViewSet,
    basename="news"
)
router.register(
    r'offfer',
    views.OfferViewSet,
    basename="offer"
)
router.register(
    r'item',
    views.ItemViewSet,
    basename="item"
)
router.register(
    r'itembase',
    views.ItemBaseViewSet,
    basename="itembase"
)
router.register(
    r'category',
    views.CategoryViewSet,
    basename="category"
)
router.register(
    r'repair',
    views.RepairViewSet,
    basename="repair"
)
router.register(
    r'visit',
    views.VisitViewSet,
    basename="visit"
)
router.register(
    r'car',
    views.CarViewSet,
    basename="car"
)
router.register(
    r'userinfo',
    views.UserInfoViewSet,
    basename="userinfo"
)
router.register(
    r'carmodel',
    views.CarModelViewSet,
    basename="carmodel"
)
router.register(
    r'carbrand',
    views.CarBrandViewSet,
    basename="carbrand"
)
router.register(
    r'carbrandmodel',
    views.CarBrandModelViewSet,
    basename="carbrandmodel"
)
router.register(
    r'cartype',
    views.CarTypeViewSet,
    basename="cartype"
)

s = static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

urlpatterns = [
    path('', include(router.urls)),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('thenewestnews/',views.NewNewsList.as_view()),
    path('thenewestoffers/',views.NewOfferList.as_view()),
    path('yourreparingcars/',views.YourReparingCars.as_view()),
    path('docs/',include_docs_urls(title="Documentation API mechanic",public=False,authentication_classes=[BasicAuthentication]))
]+s