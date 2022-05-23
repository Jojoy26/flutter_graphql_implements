import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMatchButton extends StatelessWidget {

  const CreateMatchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bookMatchController = Modular.get<BookMatchController>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)
      ),
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFE51C44),
          onSurface: Color(0xFFE51C44),
          
        ),
        onPressed: bookMatchController.createMatch, 
        child: Text(
          "Agendar",
          style: GoogleFonts.inter(
            color: Color(0xFFDDE3F0),
            fontSize: 15,
            fontWeight: FontWeight.w400
          ),
        )
      ),
    );
  }
}
