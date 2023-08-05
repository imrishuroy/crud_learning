import 'dart:convert';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? title;
  final String? body;
  final int? userId;
  final int? id;

  const Post({
    this.title,
    this.body,
    this.userId,
    this.id,
  });

  Post copyWith({
    String? title,
    String? body,
    int? userId,
    int? id,
  }) {
    return Post(
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'userId': userId,
      'id': id,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [title, body, userId, id];
}
