var baseurl = "192.168.1.3:80";

Uri geturlNotes() {
  String url = "notes/";

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
