import 'dart:convert';

import '../classess/myuserinfo.dart';
import '../urls.dart';

fetchMyUserInfo(session) async {
  final response = await session.get(geturlMyUserInfo());

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseMyuserinfo = jsonDecode(response.body);
    print(responseMyuserinfo);

    return Myuserinfo.fromMap(responseMyuserinfo);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load My user info.');
  }
}
