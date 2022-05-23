import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_gameplay/src/pages/bookMatch/widgets/bottom_sheet_games.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectGame extends StatelessWidget {
  const SelectGame({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bookMatchController = Modular.get<BookMatchController>();

    void showGames(context) {
      showModalBottomSheet(
        backgroundColor: Color(0xFF0E1647),
        constraints: BoxConstraints.loose(Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.8)),
        isScrollControlled: true,
        context: context, 
        builder: (context) {
          return BottomSheetGames();
        }
      );
    }

    return InkWell(
      onTap: (){
        showGames(context);
      },
      child: Container(
        padding: EdgeInsets.only(right: 32),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xFF243189)
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        width: double.infinity,
        height: 68,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() =>
              Container(
                width: 64,
                height: 68,
                decoration: BoxDecoration(
                  color: Color(0xFF1D2766),
                  borderRadius: BorderRadius.circular(7) ,
                  image: bookMatchController.gameSelected.value != -1 ? 
                    DecorationImage(
                      image: NetworkImage(bookMatchController.gamesList[bookMatchController.gameSelected.value].image)
                    ) :
                    null   
                ),
              ) 
            ),
            Obx(() => 
              Text(
                bookMatchController.gameSelected.value != -1 ? bookMatchController.gamesList[bookMatchController.gameSelected.value].name :
                  "Selecione um jogo",
                style: GoogleFonts.rajdhani(
                  color: Color(0xFFDDE3F0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              )
            ),
            Icon(
              Icons.arrow_right, 
              color: Color(0xFFABB1CC),
            )
          ],
        ),
      ),
    );
  }
}
