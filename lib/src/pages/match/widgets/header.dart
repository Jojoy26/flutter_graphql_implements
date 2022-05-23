import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/match_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderMatch extends StatelessWidget with PreferredSizeWidget{
  const HeaderMatch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final matchController = Modular.get<MatchController>();

    return AppBar(
        leading: IconButton(
        onPressed: matchController.backToHome, 
        icon: Icon(Icons.arrow_back)
      ),
      backgroundColor: Color(0xFF1D2766),
      title: Text(
        matchController.match.value!.title,
        style: GoogleFonts.rajdhani(
          color: Color(0xFFDDE3F0),
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      centerTitle: true,
      actions: [
        Obx(() =>
        matchController.match.value!.isInTheGroup ? 
          IconButton(
            onPressed: matchController.goToChat,
            icon: Icon(Icons.message)
          ) : Container()
        ) 
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}