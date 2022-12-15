import 'dart:convert';

import '../classess/categories.dart';
import '../classess/itembases.dart';
import '../classess/mycars.dart';
import '../classess/myreservations.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../urls.dart';

fetchMyCars(session) async {
  List<Mycars> responseMyCars = [];
  final response = await session.get(geturlMyCars());

  print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseCars = jsonDecode(utf8.decode(response.bodyBytes));
    responseCars['results'].forEach((element) {
      responseMyCars.add(Mycars.fromMap(element));
    });

    print(responseCars);
    return responseMyCars;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load My Cars');
  }
}
