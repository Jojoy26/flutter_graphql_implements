import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gameplay/src/models/match_model.dart';

class MatchContent extends StatelessWidget {

  final MatchModel model;

  const MatchContent({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.35;
    return SliverAppBar(
      backgroundColor: Color(0xFF0E1647).withOpacity(0.25),
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
        children: [
          Container(
            height: height,
            child: Image.network(
              model.game.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.85), Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.35)]
              )
            ),
          ),
          Positioned.fill(
            bottom: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    model.game.name,
                    style: GoogleFonts.rajdhani(
                      color: Color(0xFFDDE3F0),
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    model.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFDDE3F0)
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
      ),
    );
  }
}
