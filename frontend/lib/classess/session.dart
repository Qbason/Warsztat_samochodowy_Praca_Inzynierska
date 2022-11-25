import 'package:first_project/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Session {
  final http.Client client = http.Client();
  late String tokenaccess;
  late String tokenrefresh;

  Future<bool> attemptLogIn(String username, String password) async {
    var responseCreateToken = await client.post(
      geturlCreateToken(),
      body: {"username": username, "password": password},
    );
    if (responseCreateToken.statusCode == 200) {
      final body = json.decode(responseCreateToken.body);
      tokenaccess = body['access'];
      tokenrefresh = body['refresh'];
      return true;
    }
    return false;
  }

  Future<bool> refreshToken() async {
    var responseRefreshToken = await client.post(
      geturlRefreshToken(),
      body: {"refresh": tokenrefresh},
    );
    if (responseRefreshToken.statusCode == 200) {
      final body = json.decode(responseRefreshToken.body);
      tokenaccess = body['access'];
      //print('REFRESHUJEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
      return true;
    }
    return false;
  }

  baserequest(url, method, {body = ''}) async {
    // Send authorization headers to the backend.
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer $tokenaccess',
    };
    dynamic response;
    if (method == 'get') {
      response = await client.get(url, headers: headers);
    } else if (method == 'post') {
      response = await client.post(url, headers: headers, body: body);
    }
    return response;
  }

// refresh everytime using get when token expire(after 5 min)
  get(url) async {
    var response = await baserequest(url, 'get');

    if (response.statusCode == 401) {
      await refreshToken();
      response = await baserequest(url, 'get');
    }

    return response;
  }

// post function - sending data to database

  post(url, {body = ''}) async {
    var response = await baserequest(url, 'post', body: body);

    if (response.statusCode == 401) {
      await refreshToken();
      response = await baserequest(url, 'post', body: body);
    }

    return response;
  }
// update function - zmiana czegos w bazie(caly wiersz)

// partial update - zmiana poszczegolnych pol nie calego wiersza np. awatara
}
