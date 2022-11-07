var baseurl = "jakubk.pl:2136";

Uri geturlCreateToken() {
  String url = "api/token/";

  return Uri.http(baseurl, url);
}

Uri geturlRefreshToken() {
  String url = "/api/token/refresh/";

  return Uri.http(baseurl, url);
}

Uri geturlNews(queryParameters) {
  String url = "thenewestnews/";

  return Uri.http(baseurl, url, queryParameters);
}

Uri createurlNote() {
  String url = "notes/";

  return Uri.http(baseurl, url);
}

Uri geturlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}

Uri updateurlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}

Uri deleteurlNote(int id) {
  String url = "notes/$id/";

  return Uri.http(baseurl, url);
}
