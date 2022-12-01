// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Myreservations {
  int pk;
  int itembase;
  String title;
  String description;
  String price;
  String? image;
  String datecreated;
  int reservednumber;
  Myreservations({
    required this.pk,
    required this.itembase,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.datecreated,
    required this.reservednumber,
  });

  Myreservations copyWith({
    int? pk,
    int? itembase,
    String? title,
    String? description,
    String? price,
    String? image,
    String? datecreated,
    int? reservednumber,
  }) {
    return Myreservations(
      pk: pk ?? this.pk,
      itembase: itembase ?? this.itembase,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      datecreated: datecreated ?? this.datecreated,
      reservednumber: reservednumber ?? this.reservednumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'itembase': itembase,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'datecreated': datecreated,
      'reservednumber': reservednumber,
    };
  }

  factory Myreservations.fromMap(Map<String, dynamic> map) {
    return Myreservations(
      pk: map['pk'] as int,
      itembase: map['itembase'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      image: map['image'] as String?,
      datecreated: map['date_created'] as String,
      reservednumber: map['reserved_number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Myreservations.fromJson(String source) =>
      Myreservations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Myreservations(pk: $pk, itembase: $itembase, title: $title, description: $description, price: $price, image: $image, datecreated: $datecreated, reservednumber: $reservednumber)';
  }

  @override
  bool operator ==(covariant Myreservations other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.itembase == itembase &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.image == image &&
        other.datecreated == datecreated &&
        other.reservednumber == reservednumber;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        itembase.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode ^
        datecreated.hashCode ^
        reservednumber.hashCode;
  }
}
