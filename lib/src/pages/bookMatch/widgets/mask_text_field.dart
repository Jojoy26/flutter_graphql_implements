// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaskTextField extends StatelessWidget {

  final String hintText;
  final mask;
  final void Function(String text) onChanged;

  const MaskTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.mask
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextField(
        onChanged: onChanged,
        inputFormatters: [
          mask
        ],
        style: GoogleFonts.inter(
          color: Color(0xFFABB1CC),
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: Color(0xFFABB1CC),
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
          filled: true,
          fillColor: Color(0xFF1D2766),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
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
    );
  }
}
