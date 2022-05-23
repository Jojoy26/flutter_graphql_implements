import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/match_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final matchController = Modular.get<MatchController>();

    return Obx(() => 
      !matchController.match.value!.isInTheGroup ? Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: FloatingActionButton.extended(
            backgroundColor: Color(0xFFE51C44),
            isExtended: true,
            onPressed: matchController.joinMatch, 
            label: Text(
              "Entrar no servidor",
              style: GoogleFonts.inter(
                color: Color(0xFFDCDCE5),
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
            )
          ),
        ),
      ) : Container()
    );
  }
}