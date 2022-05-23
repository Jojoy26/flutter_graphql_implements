import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_gameplay/src/utils/card_types_list.dart';
import 'package:flutter_gameplay/src/widgets/card_type.dart';

class CardTypeList extends StatelessWidget {

  final int selectedIndex;
  final void Function(int index) onTap;
  final bool? haveSquare;

  const CardTypeList({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    this.haveSquare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(left: 4, right: 14),
      itemCount: listCardTypeModel.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return CardType(
          haveSquare: haveSquare,
          isAllSelected: false,
          image: listCardTypeModel[index].image,
          isSelected: selectedIndex == index,
          label: listCardTypeModel[index].label,
          onTap: (){
            onTap(index);
          },
        );
      }
    );
  }
}
