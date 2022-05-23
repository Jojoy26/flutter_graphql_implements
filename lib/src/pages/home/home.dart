import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/home_controller.dart';
import 'package:flutter_gameplay/src/pages/home/widgets/matchs_list.dart';
import 'package:flutter_gameplay/src/pages/home/widgets/header.dart';
import 'package:flutter_gameplay/src/widgets/card_type_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.changeUserStatus();
    controller.getMatchs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1647),
      body: SafeArea(
        minimum: EdgeInsets.only(top:30),
        child: RefreshIndicator(
          onRefresh: () async{
            await controller.getMatchs();
            return Future.value();
          },
          child: CustomScrollView(
            slivers: [
              HeaderHome(
                user: controller.user,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 25,),
                    SizedBox(
                      height: 120,
                      child: Obx(() => 
                        CardTypeList(
                          onTap: (int index){
                            if(controller.typeSelected.value == index){
                              controller.typeSelected.value = -1;
                            } else {
                              controller.typeSelected.value = index;
                            }
                            
                            controller.getMatchs();
                          },
                          selectedIndex: controller.typeSelected.value,
                        )
                      )
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Partidas agendadas",
                            style: GoogleFonts.rajdhani(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Obx(() => 
                            Text(
                              "Total ${controller.matchList.length}",
                              style: GoogleFonts.inter(
                                color: Color(0xFFABB1CC),
                                fontSize: 13,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24,)
                  ]
                )
              ),
              MatchsList()
            ],
          ),
        )
      ),
    );
  }
}