from kalendarz import views
from rest_framework.routers import DefaultRouter


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
    r'visitdescription',
    views.VisitDescriptionViewSet,
    basename="visitdescription"
)
router.register(
    r'visitreason',
    views.VisitReasonViewSet,
    basename="visitreason"
)
router.register(
    r'car',
    views.CarViewSet,
    basename="car"
)
router.register(
    r'carplace',
    views.CarPlaceViewSet,
    basename="carplace"
)
router.register(
    r'alluserinfo',
    views.UserInfoViewSet,
    basename="alluserinfo"
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
router.register(
    r'service',
    views.ServiceViewSet,
    basename="service"
)
router.register(
    r'servicename',
    views.ServiceNameViewSet,
    basename="servicename"
)



urlpatterns = [
    # path('', include(router.urls)),
    # path('thenewestnews/',views.NewNewsList.as_view()),
    # path('thenewestoffers/',views.NewOfferList.as_view()),
    # path('yourreparingcars/',views.YourReparingCars.as_view()),
    # path('generatecode/', views.GenerateCode.as_view()),
    # path('myuserinfo/', views.MyUserInfo.as_view()),
    # path('docs/',include_docs_urls(title="Documentation API mechanic",public=False,authentication_classes=[BasicAuthentication]))
]