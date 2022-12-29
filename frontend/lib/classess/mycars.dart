// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Mycars {
  int pk;
  String nrVIN;
  String? photo;
  String carbrand;
  String carmodel;
  String cartype;
  Mycars({
    required this.pk,
    required this.nrVIN,
    required this.photo,
    required this.carbrand,
    required this.carmodel,
    required this.cartype,
  });

  Mycars copyWith({
    int? pk,
    String? nrVIN,
    String? photo,
    String? carbrand,
    String? carmodel,
    String? cartype,
  }) {
    return Mycars(
      pk: pk ?? this.pk,
      nrVIN: nrVIN ?? this.nrVIN,
      photo: photo ?? this.photo,
      carbrand: carbrand ?? this.carbrand,
      carmodel: carmodel ?? this.carmodel,
      cartype: cartype ?? this.cartype,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'NrVIN': nrVIN,
      'photo': photo,
      'carbrand': carbrand,
      'carmodel': carmodel,
      'cartype': cartype,
    };
  }

  factory Mycars.fromMap(Map<String, dynamic> map) {
    return Mycars(
      pk: map['pk'] as int,
      nrVIN: map['Nr_VIN'] as String,
      photo: map['photo'] != null ? map['photo'] as String : null,
      carbrand: map['carbrandmodel']['carbrand']['brand'] as String,
      carmodel: map['carbrandmodel']['carmodel']['model'] as String,
      cartype: map['cartype']['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Mycars.fromJson(String source) =>
      Mycars.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Mycars(pk: $pk, nrVIN: $nrVIN, photo: $photo, carbrand: $carbrand, carmodel: $carmodel, cartype: $cartype)';
  }

  @override
  bool operator ==(covariant Mycars other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.nrVIN == nrVIN &&
        other.photo == photo &&
        other.carbrand == carbrand &&
        other.carmodel == carmodel &&
        other.cartype == cartype;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        nrVIN.hashCode ^
        photo.hashCode ^
        carbrand.hashCode ^
        carmodel.hashCode ^
        cartype.hashCode;
  }
}
