from django.urls import path, include
from rest_framework.routers import DefaultRouter
from shop import views

router = DefaultRouter()

router.register(
    r'offer',
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
    r'categoryClient',
    views.CategoryClientViewSet,
    basename='categoryClient'
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

router.register(
    r'cancelreservation',
    views.CancelReservationOffer,
    basename='cancelreservation'
)
router.register(
    r'myreservation',
    views.MyReservedItems,
    basename='myreservation'
)
router.register(
    r'offerbycategory',
    views.OfferByCategory,
    basename='offerbycategory'
)
router.register(
    r'offersearchbytitle',
    views.OfferSearchByTitleViewSet,
    basename='offersearchbytitle'
)
router.register(
    r'addnewproduct',
    views.AddNewProduct,
    basename='addnewproduct'
)



urlpatterns = [
    # path('thenewestoffers/',views.TheNewestOffers.as_view()),
    # path('makereservation/',views.MakeReservationOffer.as_view())
    path('',include(router.urls))
    
]
