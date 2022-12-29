// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Myrepairingcarsids {
  int pk;
  int visitid;
  List<dynamic> servicesids;
  Myrepairingcarsids({
    required this.pk,
    required this.visitid,
    required this.servicesids,
  });

  Myrepairingcarsids copyWith({
    int? pk,
    int? visitid,
    List<dynamic>? servicesids,
  }) {
    return Myrepairingcarsids(
      pk: pk ?? this.pk,
      visitid: visitid ?? this.visitid,
      servicesids: servicesids ?? this.servicesids,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'visitid': visitid,
      'servicesids': servicesids,
    };
  }

  factory Myrepairingcarsids.fromMap(Map<String, dynamic> map) {
    return Myrepairingcarsids(
      pk: map['pk'] as int,
      visitid: map['visit'] as int,
      servicesids: List<dynamic>.from((map['services'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Myrepairingcarsids.fromJson(String source) =>
      Myrepairingcarsids.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Myrepairingcarsids(pk: $pk, visitid: $visitid, servicesids: $servicesids)';

  @override
  bool operator ==(covariant Myrepairingcarsids other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.pk == pk &&
        other.visitid == visitid &&
        listEquals(other.servicesids, servicesids);
  }

  @override
  int get hashCode => pk.hashCode ^ visitid.hashCode ^ servicesids.hashCode;
}
