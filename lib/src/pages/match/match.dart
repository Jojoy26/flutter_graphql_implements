import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/match_controller.dart';
import 'package:flutter_gameplay/src/models/match_model.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/custom_floating_action_button.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/header.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/match_content.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/user_card.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/user_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({ Key? key }) : super(key: key);

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {

  MatchModel model = Get.arguments;

  final controller = Modular.get<MatchController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.match = model.obs;
    controller.getUsers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    Modular.dispose<MatchController>();
  }
    
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF0E1647),
      appBar: HeaderMatch(),
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      body: CustomScrollView(
        slivers: [
          MatchContent(model: controller.match.value as MatchModel),
          UserList()
        ] 
      ),
    );
  }
}