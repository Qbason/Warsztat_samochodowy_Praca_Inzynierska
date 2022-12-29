from django.urls import path, include
from rest_framework.routers import DefaultRouter
from news import views

router = DefaultRouter()

router.register(
    r'news',
    views.NewsViewSet,
    basename="news"
)
router.register(
    r'thenewest',
    views.TheNewestNews,
    basename="thenewest"
)

urlpatterns = [
    path('', include(router.urls)),
]

    # path('thenewestoffers/',views.NewOfferList.as_view()),
    # path('yourreparingcars/',views.YourReparingCars.as_view()),
    # path('generatecode/', views.GenerateCode.as_view()),
