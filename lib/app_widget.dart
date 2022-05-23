import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/book_match.dart';
import 'package:flutter_gameplay/src/pages/chat/chat.dart';
import 'package:flutter_gameplay/src/pages/home/home.dart';
import 'package:flutter_gameplay/src/pages/login/login.dart';
import 'package:flutter_gameplay/src/pages/splash/splash.dart';
import 'package:get/get.dart';

import 'src/pages/match/match.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashPage(),
      getPages: [
        GetPage(name: "/login", page: () => LoginPage(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/bookmatch", page: () => BookMatch(),),
        GetPage(name: "/match", page: () => MatchPage(),),
        GetPage(name: "/chat", page: () => ChatPage(), opaque: false)
      ],
    );
  }
}