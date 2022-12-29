import 'dart:convert';

import 'package:first_project/classess/myrepairingcars.dart';
import 'package:first_project/classess/myrepairingcarsids.dart';

import '../classess/categories.dart';
import '../classess/itembases.dart';
import '../classess/mycars.dart';
import '../classess/myreservations.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../classess/services.dart';
import '../classess/visits.dart';
import '../urls.dart';

fetchMyCars(session) async {
  List<Mycars> responseMyCars = [];
  final response = await session.get(geturlMyCars());

  //print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseCars = jsonDecode(utf8.decode(response.bodyBytes));
    responseCars['results'].forEach((element) {
      responseMyCars.add(Mycars.fromMap(element));
    });

    //print(responseCars);
    return responseMyCars;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load My Cars');
  }
}

fetchMyReparingCars(session) async {
  List<Myrepairingcarsids> responseMyrepairingcarsids = [];
  List<Myrepairingcars> myrepairingcarsfinal = [];
  final response = await session.get(geturlMyRepairingCars());

  //print(response.statusCode);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final responseMyrepairingcarsids1 =
        jsonDecode(utf8.decode(response.bodyBytes));
    responseMyrepairingcarsids1['results'].forEach((element) {
      responseMyrepairingcarsids.add(Myrepairingcarsids.fromMap(element));
    });

    print('karol pacz');
    print(responseMyrepairingcarsids);

    for (var repairingcar in responseMyrepairingcarsids) {
      int pk1 = repairingcar.pk;
      Visits visit1;
      List<Services> services1 = [];
      var responsevisit =
          await session.get(geturlVisitClient(repairingcar.visitid));
      if (responsevisit.statusCode == 200) {
        var responsevisit1 = jsonDecode(utf8.decode(responsevisit.bodyBytes));
        visit1 = Visits.fromMap(responsevisit1);
        for (var serviceid in repairingcar.servicesids) {
          var responseservice =
              await session.get(geturlServiceClient(serviceid));
          if (responseservice.statusCode == 200) {
            final responseservice1 =
                jsonDecode(utf8.decode(responseservice.bodyBytes));
            services1.add(Services.fromMap(responseservice1));
          } else {
            // If the server did not return a 200 OK response,
            // then throw an exception.
            throw Exception('Failed to load service');
          }
        }
        myrepairingcarsfinal.add(Myrepairingcars(
          pk: pk1,
          visit: visit1,
          services: services1,
        ));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load visit');
      }
    }
    return myrepairingcarsfinal;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load My repairing cars');
  }
}
