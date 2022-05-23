import 'dart:convert';

import 'package:flutter_gameplay/src/models/game_model.dart';
import 'package:flutter_gameplay/src/models/user_model.dart';

class MatchModel {

  final int id;
  final String title;
  final String description;
  final int chatId;
  final String date;
  final String createdBy;
  final List<UserModel> users;
  final int typeMatch;
  final GameModel game;
  bool isInTheGroup;
  
  MatchModel({
    required this.id,
    required this.title,
    required this.description,
    required this.chatId,
    required this.date,
    required this.createdBy,
    required this.users,
    required this.typeMatch,
    required this.game,
    required this.isInTheGroup
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'chatId': chatId,
      'date': date,
      'createdBy': createdBy,
      'users': users.map((x) => x.toMap()).toList(),
      'typeMatch': typeMatch,
      'game': game.toMap(),
      'isInTheGroup': isInTheGroup
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      chatId: map['chatId'] ?? 0,
      date: map['date'] ?? '',
      createdBy: map['createdBy'] ?? '',
      users: List<UserModel>.from(map['users']?.map((x) => UserModel.fromServerMap(x))),
      typeMatch: map['typeMatch'] ?? 0,
      game: GameModel.fromMap(map['game']),
      isInTheGroup: map['isInTheGroup'] ?? false
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchModel.fromJson(String source) => MatchModel.fromMap(json.decode(source));
}
