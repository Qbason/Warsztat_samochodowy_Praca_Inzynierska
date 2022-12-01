// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Mycars {
  int id;
  String NrVIN;
  String photo;
  int carbrandmodel;
  int cartype;
  int owner;
  Mycars({
    required this.id,
    required this.NrVIN,
    required this.photo,
    required this.carbrandmodel,
    required this.cartype,
    required this.owner,
  });

  Mycars copyWith({
    int? id,
    String? NrVIN,
    String? photo,
    int? carbrandmodel,
    int? cartype,
    int? owner,
  }) {
    return Mycars(
      id: id ?? this.id,
      NrVIN: NrVIN ?? this.NrVIN,
      photo: photo ?? this.photo,
      carbrandmodel: carbrandmodel ?? this.carbrandmodel,
      cartype: cartype ?? this.cartype,
      owner: owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'NrVIN': NrVIN,
      'photo': photo,
      'carbrandmodel': carbrandmodel,
      'cartype': cartype,
      'owner': owner,
    };
  }

  factory Mycars.fromMap(Map<String, dynamic> map) {
    return Mycars(
      id: map['id'] as int,
      NrVIN: map['Nr_VIN'] as String,
      photo: map['photo'] as String,
      carbrandmodel: map['carbrandmodel'] as int,
      cartype: map['cartype'] as int,
      owner: map['owner'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Mycars.fromJson(String source) =>
      Mycars.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Mycars(id: $id, NrVIN: $NrVIN, photo: $photo, carbrandmodel: $carbrandmodel, cartype: $cartype, owner: $owner)';
  }

  @override
  bool operator ==(covariant Mycars other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.NrVIN == NrVIN &&
        other.photo == photo &&
        other.carbrandmodel == carbrandmodel &&
        other.cartype == cartype &&
        other.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        NrVIN.hashCode ^
        photo.hashCode ^
        carbrandmodel.hashCode ^
        cartype.hashCode ^
        owner.hashCode;
  }
}
