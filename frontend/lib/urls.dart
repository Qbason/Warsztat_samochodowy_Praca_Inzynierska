var baseurl = "jakubk.pl:2136";

Uri geturlNews() {
  String url = "news/1/";

  return Uri.http(baseurl, url);
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
