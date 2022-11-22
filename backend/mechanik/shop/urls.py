from django.urls import path, include
from rest_framework.routers import DefaultRouter
from shop import views

router = DefaultRouter()

router.register(
    r'offers',
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
    basename='itembase'
)
router.register(
    r'itembaseClient',
    views.ItemBaseForClientViewSet,
    basename='itembaseClient'
)
router.register(
    r'category',
    views.CategoryViewSet,
    basename='category'
)
router.register(
    r'reservation',
    views.ReservationViewSet,
    basename='reservation'
)
router.register(
    r'makereservation',
    views.MakeReservationOffer,
    basename='makereservation'
)
router.register(
    r'thenewestoffers',
    views.TheNewestOffers,
    basename='thenewestoffers'
)



urlpatterns = [
    # path('thenewestoffers/',views.TheNewestOffers.as_view()),
    # path('makereservation/',views.MakeReservationOffer.as_view())
    path('',include(router.urls))
    
]
