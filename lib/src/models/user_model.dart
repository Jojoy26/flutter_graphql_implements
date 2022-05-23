import 'dart:convert';

class UserModel {
  final String id;
  final String username;
  final String profileImage;
  final bool isOnline;
  UserModel({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.isOnline
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'profile_image': profileImage,
    };
  }

  // Used only in login_controller
  factory UserModel.fromDiscordMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      profileImage: map['avatar'] != null ? 
        'https://cdn.discordapp.com/avatars/${map['id']}/${map['avatar']}.png' 
        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      isOnline: map['status'] ?? false
    );
  }

  factory UserModel.fromServerMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      profileImage: map['profile_image'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      isOnline: map['status'] ?? false
    );
  }

  String toJson() => json.encode(toMap());
}
