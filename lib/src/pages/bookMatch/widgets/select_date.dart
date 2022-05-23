import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/mask_text_field.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final bookMatchController = Modular.get<BookMatchController>();

    var maskDate = MaskTextInputFormatter(
      mask: '##/##', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
    );

    var maskTime = MaskTextInputFormatter(
      mask: '##:##', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
    );

    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dia e mês",
                style: GoogleFonts.rajdhani(
                  color: Color(0xFFDDE3F0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              SizedBox(height: 12,),
              MaskTextField(
                hintText: "dd/mm",
                mask: maskDate,
                onChanged: (String text){
                  bookMatchController.date.value = text;
                }
              )
            ],
          ),
        ),
        SizedBox(width: 20,),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Horário",
                style: GoogleFonts.rajdhani(
                  color: Color(0xFFDDE3F0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              SizedBox(height: 12,),
              MaskTextField(
                hintText: "hh:mm",
                mask: maskTime,
                onChanged: (String text){
                  bookMatchController.time.value = text;
                }
              )
            ],
          ),
        )
      ],
    );
  }
}