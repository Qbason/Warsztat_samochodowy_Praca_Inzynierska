// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Itembases {
  int pk;
  String name;
  String condition;
  int category;
  String price;

  Itembases({
    required this.pk,
    required this.name,
    required this.condition,
    required this.category,
    required this.price,
  });

  Itembases copyWith({
    int? pk,
    String? name,
    String? condition,
    int? category,
    String? price,
  }) {
    return Itembases(
      pk: pk ?? this.pk,
      name: name ?? this.name,
      condition: condition ?? this.condition,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'name': name,
      'condition': condition,
      'category': category,
      'price': price,
    };
  }

  factory Itembases.fromMap(Map<String, dynamic> map) {
    return Itembases(
      pk: map['pk'] as int,
      name: map['name'] as String,
      condition: map['condition'] as String,
      category: map['category'] as int,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Itembases.fromJson(String source) =>
      Itembases.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Itembases(pk: $pk, name: $name, condition: $condition, category: $category, price: $price)';
  }

  @override
  bool operator ==(covariant Itembases other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.name == name &&
        other.condition == condition &&
        other.category == category &&
        other.price == price;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        name.hashCode ^
        condition.hashCode ^
        category.hashCode ^
        price.hashCode;
  }
}
