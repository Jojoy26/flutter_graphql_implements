import 'dart:convert';

import 'package:flutter_gameplay/src/models/user_model.dart';

class MessageModel {
  final int id;
  final String message;
  final DateTime createdAt;
  final UserModel user;
  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'user': user.toMap(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      message: map['message'] ?? '',
      createdAt: DateTime.parse(map['createdAt']).toUtc().toLocal(),
      user: UserModel.fromServerMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));
}
