from django.urls import path, include
from rest_framework.routers import DefaultRouter
from news import views

router = DefaultRouter()
router.register(
    r'',
    views.NewsViewSet,
    basename="news"
)

urlpatterns = [
    path('thenewest/',views.NewNewsList.as_view()),
    path('', include(router.urls)),
]

    # path('thenewestoffers/',views.NewOfferList.as_view()),
    # path('yourreparingcars/',views.YourReparingCars.as_view()),
    # path('generatecode/', views.GenerateCode.as_view()),
    # path('myuserinfo/', views.MyUserInfo.as_view()),