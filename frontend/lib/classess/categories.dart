// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categories {
  int pk;
  String name;
  Categories({
    required this.pk,
    required this.name,
  });

  Categories copyWith({
    int? pk,
    String? name,
  }) {
    return Categories(
      pk: pk ?? this.pk,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'name': name,
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      pk: map['pk'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Categories(pk: $pk, name: $name)';

  @override
  bool operator ==(covariant Categories other) {
    if (identical(this, other)) return true;

    return other.pk == pk && other.name == name;
  }

  @override
  int get hashCode => pk.hashCode ^ name.hashCode;
}
