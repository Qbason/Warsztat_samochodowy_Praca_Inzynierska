"""mechanik URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include,path
from rest_framework.documentation import include_docs_urls
from django.conf.urls.static import static
from django.conf import settings
from rest_framework.authentication import BasicAuthentication
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    path('news/', include('news.urls')),
    path('userinfo/', include('userinfo.urls')),
    path('shop/',include('shop.urls')),
    path('visit/',include('visit.urls')),
    path('garage/',include('garage.urls')),
    path('car/',include('car.urls')),
    path('event/',include('event.urls')),


    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('admin/', admin.site.urls),
    path('docs/',include_docs_urls(title="Documentation API mechanic",public=False,authentication_classes=[BasicAuthentication]))
    # path(r'docs/', include_docs_urls(title='Polls API',public=True,authentication_classes=[BasicAuthentication],permission_classes=[IsAuthenticated]))

]+static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
