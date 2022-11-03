from kalendarz import views
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.conf.urls.static import static
from django.conf import settings

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

s = static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

urlpatterns = [
    path('', include(router.urls)),
    path('thenewestnews/',views.NewNewsList.as_view()),
    path('thenewestoffers/',views.NewOfferList.as_view()),
    path('docs/',include_docs_urls(title="Documentation API mechanic",public=False))
]+s