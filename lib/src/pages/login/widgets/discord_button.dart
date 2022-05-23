import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscordButton extends StatelessWidget {

  final Future<void> Function() onPressed;

  const DiscordButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10)
      ),
      color: Color(0xFFE51C44),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          color: Colors.transparent,
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(right: 22, left: 22),
                child: SvgPicture.asset(
                  'lib/src/assets/images/discord.svg',
                ),
              ),
              Container(
                width: 0.5, 
                height: double.infinity,
                color: Color(0xFF0E1332),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                  child: Text(
                      "Entrar com discord",
                      style: GoogleFonts.inter(
                        color: Color(0xFFDCDCE5),
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
