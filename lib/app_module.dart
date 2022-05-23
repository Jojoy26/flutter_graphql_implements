import 'package:dio/dio.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_gameplay/src/controllers/chat_controller.dart';
import 'package:flutter_gameplay/src/controllers/home_controller.dart';
import 'package:flutter_gameplay/src/controllers/login_controller.dart';
import 'package:flutter_gameplay/src/controllers/splash_controller.dart';
import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'src/controllers/match_controller.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.factory<Dio>((i) => Dio()),
    Bind.singleton<GraphQLClientHelper>((i) => GraphQLClientHelper()),

    Bind.singleton<UserController>((i) => UserController()),
    Bind.factory<LoginController>((i) => LoginController(dio: i(), userController: i(), clientHelper: i())),
    Bind.singleton<HomeController>((i) => HomeController(userController: i(), clientHelper: i())),
    Bind.singleton<BookMatchController>((i) => BookMatchController(userController: i(), clientHelper: i())),
    Bind.singleton<MatchController>((i) => MatchController(userController: i(), clientHelper: i())),
    Bind.singleton<ChatController>((i) => ChatController(userController: i(), clientHelper: i())),
    Bind.factory<SplashController>((i) => SplashController()),
  ];
}