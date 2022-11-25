import 'dart:convert';

import 'package:flutter/material.dart';

import '../classess/categories.dart';
import '../classess/itembases.dart';
import '../classess/news.dart';
import '../classess/offers.dart';
import '../urls.dart';

postmakeReservation(session, pk, number) async {
  dynamic body = jsonEncode(<String, String>{'pk': '$pk', 'number': '$number'});

  final response = await session.post(posturlMakeReservation(), body: body);
  //print('tukeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeej');
  // błędy 406 - all items already has been reserved
  // błędy 400 - błędna walidacja - oferta nie istnieje lub próbuje zarezerwować więcej niż może

  // ZROBIIIIIIIIIIIIIIIIIIIIIIIIIIIIIĆ
  // ifami zeby zwrocilo dobry blad i potem na podstawie tego w wygladzie wyswietli jakis komunikat dla uzytkownika
  print(response.statusCode);
  print(response.body);

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  var checkpk = data.containsKey('pk');
  var checknumber = data.containsKey('number');
  var checkinfo = data.containsKey('info');

  if (response.statusCode == 406 || response.statusCode == 400) {
    if (checkpk && checknumber) {
      return [
        'Kod błędu: ${response.statusCode}',
        '${data['pk'][0]}.\n${data['number'][0]}'
      ];
    } else if (checkpk) {
      return ['Kod błędu: ${response.statusCode}', '${data['pk'][0]}'];
    } else if (checknumber) {
      return ['Kod błędu: ${response.statusCode}', '${data['number'][0]}'];
    } else {
      return ['Kod błędu: ${response.statusCode}', '${data['info']}.'];
    }
    ;
  }
}

postcancelReservation(session, pk, number) async {
  dynamic body = jsonEncode(<String, String>{'pk': '$pk', 'number': '$number'});

  final response = await session.post(posturlCancelReservation(), body: body);
  //print('tukeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeej');
  // błędy 406 - all items already has been reserved
  // błędy 400 - błędna walidacja - oferta nie istnieje lub próbuje zarezerwować więcej niż może

  // ZROBIIIIIIIIIIIIIIIIIIIIIIIIIIIIIĆ
  // ifami zeby zwrocilo dobry blad i potem na podstawie tego w wygladzie wyswietli jakis komunikat dla uzytkownika
  print(response.statusCode);
  print(response.body);
  print('cancelujeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  var checkpk = data.containsKey('pk');
  var checknumber = data.containsKey('number');
  var checkinfo = data.containsKey('info');

  if (response.statusCode == 406 || response.statusCode == 400) {
    if (checkpk && checknumber) {
      return [
        'Kod błędu: ${response.statusCode}',
        '${data['pk'][0]}.\n${data['number'][0]}'
      ];
    } else if (checkpk) {
      return ['Kod błędu: ${response.statusCode}', '${data['pk'][0]}'];
    } else if (checknumber) {
      return ['Kod błędu: ${response.statusCode}', '${data['number'][0]}'];
    } else {
      return ['Kod błędu: ${response.statusCode}', '${data['info']}.'];
    }
    ;
  }
}
