import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gameplay/src/models/user_model.dart';

class HeaderHome extends StatelessWidget {

  final UserModel user;

  const HeaderHome({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      leadingWidth: 0,
      floating: true,
      backgroundColor: Color(0xFF0E1647),
      toolbarHeight: 100,
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(user.profileImage)
            )
          ),
          height: 48,
          width: 48,
        ),
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.rajdhani(
              color: Color(0xFFDDE3F0),
              fontSize: 24
            ),
            children: [
              TextSpan(
                text: "Olá, ",
                style: TextStyle(fontWeight: FontWeight.w500)
              ),
              TextSpan(
                text: user.username,
                style: TextStyle(fontWeight: FontWeight.bold)
              )
            ]
          )
        ),
        subtitle: Text(
          "Hoje é dia de vitória", 
          style: GoogleFonts.inter(
            color: Color(0xFFABB1CC),
            fontSize: 13,
          ),
        ),
        trailing: Material(
          color: Color(0xFFE51C44),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: (){
              Get.toNamed("/bookmatch");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              padding: EdgeInsets.all(9),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ),
    );
  }
}
