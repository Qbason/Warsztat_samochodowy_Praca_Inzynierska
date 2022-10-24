// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class News {
  String title;
  String content;
  String image;
  String date_created;
  News({
    required this.title,
    required this.content,
    required this.image,
    required this.date_created,
  });

  News copyWith({
    String? title,
    String? content,
    String? image,
    String? date_created,
  }) {
    return News(
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      date_created: date_created ?? this.date_created,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'image': image,
      'date_created': date_created,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
      date_created: map['date_created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'News(title: $title, content: $content, image: $image, date_created: $date_created)';
  }

  @override
  bool operator ==(covariant News other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.image == image &&
        other.date_created == date_created;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        date_created.hashCode;
  }
}
