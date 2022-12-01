var baseurl = "jakubk.pl:2136";

// GET

Uri geturlCreateToken() {
  String url = "api/token/";

  return Uri.http(baseurl, url);
}

Uri geturlRefreshToken() {
  String url = "api/token/refresh/";

  return Uri.http(baseurl, url);
}

Uri geturlNewestOffers(queryParameters) {
  String url = "shop/thenewestoffers/";

  return Uri.http(baseurl, url, queryParameters);
}

Uri geturlOffersByTitle(queryParameters) {
  String url = "/shop/offersearchbytitle/";

  return Uri.http(baseurl, url, queryParameters);
}

Uri geturlOffersByCategory(queryParameters) {
  String url = "/shop/offerbycategory/";

  return Uri.http(baseurl, url, queryParameters);
}

Uri geturlOffers() {
  String url = "offer/";

  return Uri.http(baseurl, url);
}

Uri geturlMyUserInfo() {
  String url = "userinfo/my";
  return Uri.http(baseurl, url);
}

Uri geturlNewestNews(queryParameters) {
  String url = "/news/thenewest/";

  return Uri.http(baseurl, url, queryParameters);
}

Uri geturlNews() {
  String url = "news/";

  return Uri.http(baseurl, url);
}

Uri geturlItembase(id) {
  String url = "/shop/itembase/$id";

  return Uri.http(baseurl, url);
}

Uri geturlitembaseClient(id) {
  String url = "/shop/itembaseClient/$id";

  return Uri.http(baseurl, url);
}

Uri geturlCategoriesClient() {
  String url = "/shop/categoryClient/";

  return Uri.http(baseurl, url);
}

Uri geturlMyReservations() {
  String url = "/shop/myreservation/";

  return Uri.http(baseurl, url);
}

Uri geturlMyCars() {
  String url = "/car/mycars/";

  return Uri.http(baseurl, url);
}

// POST

Uri posturlMakeReservation() {
  String url = "/shop/makereservation/";

  return Uri.http(baseurl, url);
}

Uri posturlCancelReservation() {
  String url = "/shop/cancelreservation/";

  return Uri.http(baseurl, url);
}
