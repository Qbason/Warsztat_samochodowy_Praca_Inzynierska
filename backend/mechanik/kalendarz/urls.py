from kalendarz import views
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.conf.urls.static import static
from django.conf import settings

router = DefaultRouter()

router.register(
    r'news',
    views.NewsViewSet
)


urlpatterns = [
    path('', include(router.urls)),
]+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)