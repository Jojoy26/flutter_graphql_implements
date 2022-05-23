import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gameplay/src/controllers/home_controller.dart';
import 'package:flutter_gameplay/src/models/match_model.dart';
import 'package:flutter_gameplay/src/utils/format_date.dart';
import 'package:flutter_gameplay/src/utils/get_type_title.dart';

class MatchCard extends StatelessWidget {

  final MatchModel model;
  final void Function() onTap;

  const MatchCard({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeController = Modular.get<HomeController>();
    bool isVisitor = model.isInTheGroup && homeController.user.id != model.createdBy;
    bool notNull(Object o) => o != null;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 68,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFF243189),
                width: 1
              ),
              image: DecorationImage(
                image: NetworkImage(model.game.image)
              )
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.title,
                            style: GoogleFonts.rajdhani(
                              color: Color(0xFFDDE3F0),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            )
                          ),
                          Text(
                            getTypeTitle(model.typeMatch),
                            style: GoogleFonts.inter(
                              color: Color(0xFFABB1CC),
                              fontWeight: FontWeight.w400,
                              fontSize: 13
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 4,),
                      Text(
                        model.game.name,
                        style: GoogleFonts.inter(
                          color: Color(0xFFABB1CC),
                          fontWeight: FontWeight.w400,
                          fontSize: 13
                        ),
                      ),
                      SizedBox(height: 9,),
                      Builder(
                        builder: (context) {
                          bool isVisible = false;
                          List<Widget> _children = [
                            Wrap(
                              children: [
                                SvgPicture.asset(
                                  "lib/src/assets/images/calendar.svg"
                                ),
                                SizedBox(width: 12,),
                                Text(
                                  formatDate(model.date),
                                  style: GoogleFonts.inter(
                                    color: Color(0xFFDDE3F0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13
                                  ),
                                )
                              ],
                            ), 
                          ];

                          if (homeController.user.id != model.createdBy && !model.isInTheGroup) {
                            _children.add(
                              Wrap(
                                children: [
                                  SvgPicture.asset(
                                    "lib/src/assets/images/player.svg",
                                    color: Color(0xFFE51C44),
                                  ),
                                  SizedBox(width: 6,),
                                  Text(
                                    model.users.length.toString(),
                                    style: GoogleFonts.inter(
                                      color: Color(0xFFDDE3F0),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13
                                    ),
                                  )
                                ],
                              )
                            );
                          }

                          if (model.isInTheGroup) {
                            _children.add(
                              Text(
                                isVisitor ? "Visitante" : "Anfitrião",
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: isVisitor ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _children,
                          );
                        }
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Color(0xFF1D2766),
                ),
                SizedBox(height: 16,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
