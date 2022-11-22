var baseurl = "jakubk.pl:2136";

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

Uri geturlOffers() {
  String url = "offers/";

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

Uri geturlCategories() {
  String url = "/shop/category/";

  return Uri.http(baseurl, url);
}
