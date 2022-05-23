import 'dart:convert';

class GameModel {
  final int id;
  final String name;
  final String image;
  final String backgroundImage;
  GameModel({
    required this.id,
    required this.name,
    required this.image,
    required this.backgroundImage
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'background_image': backgroundImage
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      backgroundImage: map['background_image']
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) => GameModel.fromMap(json.decode(source));
}
