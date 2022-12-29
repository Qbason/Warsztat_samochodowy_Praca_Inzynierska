// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:first_project/classess/services.dart';

class Visits {
  int id;
  String datevisit;
  String? datevisitend;
  String visitdescritpiontitle;
  String visitdescritpioncontent;
  String visitreason;
  String carNrVIN;
  String carbrand;
  String carmodel;
  String? carphoto;
  Visits({
    required this.id,
    required this.datevisit,
    required this.datevisitend,
    required this.visitdescritpiontitle,
    required this.visitdescritpioncontent,
    required this.visitreason,
    required this.carNrVIN,
    required this.carbrand,
    required this.carmodel,
    required this.carphoto,
  });

  Visits copyWith({
    int? id,
    String? datevisit,
    String? datevisitend,
    String? visitdescritpiontitle,
    String? visitdescritpioncontent,
    String? visitreason,
    String? carNrVIN,
    String? carbrand,
    String? carmodel,
    String? carphoto,
  }) {
    return Visits(
      id: id ?? this.id,
      datevisit: datevisit ?? this.datevisit,
      datevisitend: datevisitend ?? this.datevisitend,
      visitdescritpiontitle:
          visitdescritpiontitle ?? this.visitdescritpiontitle,
      visitdescritpioncontent:
          visitdescritpioncontent ?? this.visitdescritpioncontent,
      visitreason: visitreason ?? this.visitreason,
      carNrVIN: carNrVIN ?? this.carNrVIN,
      carbrand: carbrand ?? this.carbrand,
      carmodel: carmodel ?? this.carmodel,
      carphoto: carphoto ?? this.carphoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'datevisit': datevisit,
      'datevisitend': datevisitend,
      'visitdescritpiontitle': visitdescritpiontitle,
      'visitdescritpioncontent': visitdescritpioncontent,
      'visitreason': visitreason,
      'carNrVIN': carNrVIN,
      'carbrand': carbrand,
      'carmodel': carmodel,
      'carphoto': carphoto,
    };
  }

  factory Visits.fromMap(Map<String, dynamic> map) {
    return Visits(
      id: map['id'] as int,
      datevisit: map['date_visit'] as String,
      datevisitend: map['date_visit_end'] != null
          ? map['date_visit_end'] as String
          : null,
      visitdescritpiontitle: map['visitdescription']['title'] as String,
      visitdescritpioncontent: map['visitdescription']['content'] as String,
      visitreason: map['visitreason']['reason'] as String,
      carNrVIN: map['car']['Nr_VIN'] as String,
      carbrand: map['car']['carbrandmodel']['carbrand']['brand'] as String,
      carmodel: map['car']['carbrandmodel']['carmodel']['model'] as String,
      carphoto:
          map['car']['photo'] != null ? map['car']['photo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Visits.fromJson(String source) =>
      Visits.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Visits(id: $id, datevisit: $datevisit, datevisitend: $datevisitend, visitdescritpiontitle: $visitdescritpiontitle, visitdescritpioncontent: $visitdescritpioncontent, visitreason: $visitreason, carNrVIN: $carNrVIN, carbrand: $carbrand, carmodel: $carmodel, carphoto: $carphoto)';
  }

  @override
  bool operator ==(covariant Visits other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.datevisit == datevisit &&
        other.datevisitend == datevisitend &&
        other.visitdescritpiontitle == visitdescritpiontitle &&
        other.visitdescritpioncontent == visitdescritpioncontent &&
        other.visitreason == visitreason &&
        other.carNrVIN == carNrVIN &&
        other.carbrand == carbrand &&
        other.carmodel == carmodel &&
        other.carphoto == carphoto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        datevisit.hashCode ^
        datevisitend.hashCode ^
        visitdescritpiontitle.hashCode ^
        visitdescritpioncontent.hashCode ^
        visitreason.hashCode ^
        carNrVIN.hashCode ^
        carbrand.hashCode ^
        carmodel.hashCode ^
        carphoto.hashCode;
  }
}
