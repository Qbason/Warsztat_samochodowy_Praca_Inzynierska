// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Items {
  int pk;
  int itembase;
  int? reservation;

  Items({
    required this.pk,
    required this.itembase,
    this.reservation,
  });

  Items copyWith({
    int? pk,
    int? itembase,
    int? reservation,
  }) {
    return Items(
      pk: pk ?? this.pk,
      itembase: itembase ?? this.itembase,
      reservation: reservation ?? this.reservation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'itembase': itembase,
      'reservation': reservation,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      pk: map['pk'] as int,
      itembase: map['itembase'] as int,
      reservation:
          map['reservation'] != null ? map['reservation'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Items(pk: $pk, itembase: $itembase, reservation: $reservation)';

  @override
  bool operator ==(covariant Items other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.itembase == itembase &&
        other.reservation == reservation;
  }

  @override
  int get hashCode => pk.hashCode ^ itembase.hashCode ^ reservation.hashCode;
}
