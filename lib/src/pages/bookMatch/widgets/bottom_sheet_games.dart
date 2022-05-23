import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/book_match_controller.dart';
import 'package:flutter_gameplay/src/models/game_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetGames extends StatefulWidget {

  const BottomSheetGames({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSheetGames> createState() => _BottomSheetGamesState();
}

class _BottomSheetGamesState extends State<BottomSheetGames> {

  final bookMatchController = Modular.get<BookMatchController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 13,),
        Align(
          alignment: Alignment.center,
          child: Container(
            
            height: 2,
            width: 39,
            decoration: BoxDecoration(
              color: Color(0xFF495BCC),
              borderRadius: BorderRadius.circular(3)
            ),
          ),
        ),
        SizedBox(height: 24,),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 14),
            child: Obx(() {
              if(bookMatchController.gamesIsLoading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if(!bookMatchController.gamesIsLoading.value && bookMatchController.gamesList.isEmpty ) {
                return Center(
                  child: TextButton(
                    onPressed: bookMatchController.getGames,
                    child: Text("Tentar novamente"),
                  ),
                );
              }
              return ListView.builder(
                itemCount: bookMatchController.gamesList.length,
                itemBuilder: (context, index) {

                  final GameModel game = bookMatchController.gamesList[index];

                  return GestureDetector(
                    onTap: (){

                      bookMatchController.selectGame(index);
                      Navigator.pop(context);
                      
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 68,
                              width: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(game.image)
                                )
                              ),
                            ),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 14),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          game.name,
                                          style: GoogleFonts.rajdhani(
                                            color: Color(0xFFDDE3F0),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Color(0xFFABB1CC),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12,),
                        Container(
                          margin: EdgeInsets.only(left: 84),
                          width: double.infinity,
                          height: 1,
                          color: Color(0xFF1D2766),
                        ),
                        SizedBox(height: 12,),
                      ],
                    ),
                  );
                }
              );
            })
          ),
        )
      ],
    );
  }
}