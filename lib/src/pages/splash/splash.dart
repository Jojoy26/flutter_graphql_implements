import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Modular.get<SplashController>();
    controller.getToken();
    
    return Scaffold(
      backgroundColor: Color(0xFF0A1033),
      body: SafeArea(
        child: Center(
          child: Transform.scale(
            scale: 1.9,
            child: Image.asset(
              "lib/src/assets/splash.png",
              fit: BoxFit.cover
            )
          ),
        )
      ),
    );
  }
}