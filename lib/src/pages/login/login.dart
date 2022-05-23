import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/login_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:flutter_gameplay/src/pages/login/widgets/discord_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:graphql/client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? token = Get.arguments;

  LoginController controller = Modular.get<LoginController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(token != null){
      controller.login(token);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1647),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0E1647), Color(0xFF0E1332)]
            )
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Image.asset(
                  "lib/src/assets/images/illustration.png",
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: MediaQuery.of(context).size.height * 0.10,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Conecte-se\ne organize suas\njogatinas",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Crie grupos para jogar seus games\nfavoritos com amigos",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Color(0xFFDCDCE5),
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      SizedBox(height: 40,),
                      Obx(
                        () => controller.isLoading.value ? CircularProgressIndicator() :
                          DiscordButton(
                            onPressed: () async {
                              controller.login(null);
                            }
                          )
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}