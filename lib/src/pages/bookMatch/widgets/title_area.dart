import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleArea extends StatelessWidget {

  const TitleArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    final bookMatchController = Modular.get<BookMatchController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Título",
              style: GoogleFonts.rajdhani(
                color: Color(0xFFDDE3F0),
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Text(
              "Max 20 caracteres",
              style: GoogleFonts.inter(
                color: Color(0xFFABB1CC),
                fontSize: 13,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
        SizedBox(height: 12,),
        TextField(
          onChanged: (String text){
            bookMatchController.title.value = text;
          },
          maxLength: 20,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Color(0xFFDDE3F0),
            fontWeight: FontWeight.w400
          ),
          decoration: InputDecoration(
            counterStyle: TextStyle(height: double.minPositive,),
            counterText: "",
            contentPadding: EdgeInsets.all(10),
            filled: true,
            fillColor: Color(0xFF1D2766),
            enabledBorder: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFF243189),
                width: 1
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFF243189),
                width: 1
              )
            ),
          ),
        ),
      ],
    );
  }
}
