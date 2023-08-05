import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? statusCode;
  final String? statusMessage;

  const Failure({
    this.statusCode,
    this.statusMessage,
  });

  Failure copyWith({
    int? statusCode,
    String? statusMessage,
  }) {
    return Failure(
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'statusMessage': statusMessage,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      statusMessage:
          map['statusMessage'] != null ? map['statusMessage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
