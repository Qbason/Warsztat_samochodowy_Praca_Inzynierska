// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:first_project/classess/services.dart';
import 'package:first_project/classess/visits.dart';

class Myrepairingcars {
  int pk;
  Visits visit;
  List<Services> services;
  Myrepairingcars({
    required this.pk,
    required this.visit,
    required this.services,
  });

  Myrepairingcars copyWith({
    int? pk,
    Visits? visit,
    List<Services>? services,
  }) {
    return Myrepairingcars(
      pk: pk ?? this.pk,
      visit: visit ?? this.visit,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'visit': visit.toMap(),
      'services': services.map((x) => x.toMap()).toList(),
    };
  }

  factory Myrepairingcars.fromMap(Map<String, dynamic> map) {
    return Myrepairingcars(
      pk: map['pk'] as int,
      visit: Visits.fromMap(map['visit'] as Map<String, dynamic>),
      services: List<Services>.from(
        (map['services'] as List<int>).map<Services>(
          (x) => Services.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Myrepairingcars.fromJson(String source) =>
      Myrepairingcars.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Myrepairingcars(pk: $pk, visit: $visit, services: $services)';

  @override
  bool operator ==(covariant Myrepairingcars other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.pk == pk &&
        other.visit == visit &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode => pk.hashCode ^ visit.hashCode ^ services.hashCode;
}
