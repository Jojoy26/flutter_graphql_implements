import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/match_controller.dart';
import 'package:flutter_gameplay/src/pages/match/widgets/user_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class UserList extends StatelessWidget {
  const UserList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final matchController = Modular.get<MatchController>();

    return SliverPadding(
      padding: const EdgeInsets.only(left: 14, top: 24, bottom: 70),
      sliver: Obx(() => 
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return UserCard(model: matchController.usersList[index],);
            },
            childCount: matchController.usersList.length
          )
        ),
      )
    );
  }
}