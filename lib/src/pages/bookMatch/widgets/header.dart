import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderBookMatch extends StatelessWidget with PreferredSizeWidget {
  const HeaderBookMatch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Agendar uma partida",
        style: GoogleFonts.rajdhani(
          color: Color(0xFFDDE3F0),
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
      ),
      backgroundColor: Color(0xFF1D2766),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}