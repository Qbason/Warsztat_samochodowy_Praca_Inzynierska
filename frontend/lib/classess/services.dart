// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Services {
  int id;
  String price;
  String progress;
  String? datestart;
  int duration;
  String? dateend;
  String servicename;
  Services({
    required this.id,
    required this.price,
    required this.progress,
    required this.datestart,
    required this.duration,
    required this.dateend,
    required this.servicename,
  });

  Services copyWith({
    int? id,
    String? price,
    String? progress,
    String? datestart,
    int? duration,
    String? dateend,
    String? servicename,
  }) {
    return Services(
      id: id ?? this.id,
      price: price ?? this.price,
      progress: progress ?? this.progress,
      datestart: datestart ?? this.datestart,
      duration: duration ?? this.duration,
      dateend: dateend ?? this.dateend,
      servicename: servicename ?? this.servicename,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'progress': progress,
      'datestart': datestart,
      'duration': duration,
      'dateend': dateend,
      'servicename': servicename,
    };
  }

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      id: map['id'] as int,
      price: map['price'] as String,
      progress: map['progress'] as String,
      datestart: map['date_start'] != null ? map['date_start'] as String : null,
      duration: map['duration'] as int,
      dateend: map['date_end'] != null ? map['date_end'] as String : null,
      servicename: map['servicename']['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Services.fromJson(String source) =>
      Services.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Services(id: $id, price: $price, progress: $progress, datestart: $datestart, duration: $duration, dateend: $dateend, servicename: $servicename)';
  }

  @override
  bool operator ==(covariant Services other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        other.progress == progress &&
        other.datestart == datestart &&
        other.duration == duration &&
        other.dateend == dateend &&
        other.servicename == servicename;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        progress.hashCode ^
        datestart.hashCode ^
        duration.hashCode ^
        dateend.hashCode ^
        servicename.hashCode;
  }
}
