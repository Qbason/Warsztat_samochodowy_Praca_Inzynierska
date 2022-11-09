// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Myuserinfo {
  String name;
  String surname;
  String phonenumber;
  String email;
  String avatar;

  Myuserinfo({
    required this.name,
    required this.surname,
    required this.phonenumber,
    required this.email,
    required this.avatar,
  });

  Myuserinfo copyWith({
    String? name,
    String? surname,
    String? phonenumber,
    String? email,
    String? avatar,
  }) {
    return Myuserinfo(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phonenumber: phonenumber ?? this.phonenumber,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'phonenumber': phonenumber,
      'email': email,
      'avatar': avatar,
    };
  }

  factory Myuserinfo.fromMap(Map<String, dynamic> map) {
    return Myuserinfo(
      name: map['name'] as String,
      surname: map['surname'] as String,
      phonenumber: map['phone_number'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Myuserinfo.fromJson(String source) =>
      Myuserinfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Myuserinfo(name: $name, surname: $surname, phonenumber: $phonenumber, email: $email, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant Myuserinfo other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.surname == surname &&
        other.phonenumber == phonenumber &&
        other.email == email &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        phonenumber.hashCode ^
        email.hashCode ^
        avatar.hashCode;
  }
}
