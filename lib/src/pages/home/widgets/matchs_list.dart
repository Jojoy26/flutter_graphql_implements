import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/home_controller.dart';
import 'package:flutter_gameplay/src/pages/home/widgets/match_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchsList extends StatelessWidget {
  const MatchsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final homeController = Modular.get<HomeController>();

    return SliverPadding(
      padding: EdgeInsets.only(left: 14),
      sliver: Obx(() {
        if(homeController.isLoading.value){
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: CircularProgressIndicator(),
                )
              ]
            )
          );
        } else if(!homeController.isLoading.value && !homeController.hasError.value && homeController.matchList.isEmpty){
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Text(
                        "Nenhuma partida encontrada",
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton(
                        onPressed: homeController.getMatchs, 
                        child: Text("Buscar partidas")
                      )
                    ],
                  ),
                )
              ]
            )
          );
        } else if(!homeController.isLoading.value && homeController.hasError.value) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Text(
                        "Erro ao fazer busca",
                        style: GoogleFonts.rajdhani(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextButton(
                        onPressed: homeController.getMatchs, 
                        child: Text("Tentar novamente")
                      )
                    ],
                  ),
                )
              ]
            )
          );
        } else {
            return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MatchCard(
                  onTap: (){
                    homeController.goToMatch(index);
                  },
                  model: homeController.matchList[index],
                );
              },
              childCount: homeController.matchList.length
            )
          );
        } 
      })
    );
  }
}