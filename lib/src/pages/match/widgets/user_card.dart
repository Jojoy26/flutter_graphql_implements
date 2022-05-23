import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gameplay/src/models/user_model.dart';

class UserCard extends StatelessWidget {

  final UserModel model;

  const UserCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.profileImage)
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 1,
                  color: Color(0xFF243189)
                )
              ),
            ),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.username,
                  style: GoogleFonts.rajdhani(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDDE3F0)
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: model.isOnline ? Color(0xFF32BD50) : Colors.red,
                        shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      model.isOnline ? "Online" : "Offline",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFABB1CC)
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 12,),
        Container(
          margin: EdgeInsets.only(left: 64),
          height: 1,
          width: double.infinity,
          color: Color(0xFF1D2766),
        ),
        SizedBox(height: 12,)
      ],
    );
  }
}
