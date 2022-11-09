// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Offers {
  String title;
  String description;
  String price;
  String image;
  String datecreated;
  int itembase;
  int quantity;

  Offers({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.datecreated,
    required this.itembase,
    required this.quantity,
  });

  Offers copyWith({
    String? title,
    String? description,
    String? price,
    String? image,
    String? datecreated,
    int? itembase,
    int? quantity,
  }) {
    return Offers(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      datecreated: datecreated ?? this.datecreated,
      itembase: itembase ?? this.itembase,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'datecreated': datecreated,
      'itembase': itembase,
      'quantity': quantity,
    };
  }

  factory Offers.fromMap(Map<String, dynamic> map) {
    return Offers(
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      datecreated: map['date_created'] as String,
      itembase: map['itembase'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offers.fromJson(String source) =>
      Offers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Offers(title: $title, description: $description, price: $price, image: $image, datecreated: $datecreated, itembase: $itembase, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Offers other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.price == price &&
        other.image == image &&
        other.datecreated == datecreated &&
        other.itembase == itembase &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode ^
        datecreated.hashCode ^
        itembase.hashCode ^
        quantity.hashCode;
  }
}
