// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/create_match_button.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/description_area.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/header.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/select_date.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/select_game.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/title_area.dart';
import 'package:flutter_gameplay/src/widgets/card_type_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookMatch extends StatefulWidget {
  const BookMatch({ Key? key }) : super(key: key);

  @override
  State<BookMatch> createState() => _BookMatchState();
}

class _BookMatchState extends State<BookMatch> {

  final controller = Modular.get<BookMatchController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGames();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Modular.dispose<BookMatchController>();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFF0E1647),
      appBar: HeaderBookMatch(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Text(
                "Categoria",
                style: GoogleFonts.rajdhani(
                  color: Color(0xFFDDE3F0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            SizedBox(height: 12,),
            SizedBox(
              height: 120,
              child: Obx(() => 
                CardTypeList(
                  haveSquare: true,
                  selectedIndex: controller.typeCardSelected.value, 
                  onTap: (int index) {
                    controller.typeCardSelected.value = index;
                  }
                )
              )
            ),
            SizedBox(height: 32,),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Column(
                children: [
                  SelectGame(),
                  SizedBox(height: 28,),
                  SelectDate(),
                  SizedBox(height: 28,),
                  TitleArea(),
                  SizedBox(height: 28,),
                  DescriptionArea(),
                  SizedBox(height: 40),
                  CreateMatchButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
