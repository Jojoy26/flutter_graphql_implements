import 'package:flutter_gameplay/src/models/user_model.dart';

class UserController {

  late UserModel user = UserModel(id: "", username: "", profileImage: "", isOnline: true);

  void setUser(UserModel model) {
    user = model;
  }
  
}