import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/chat_controller.dart';
import 'package:flutter_gameplay/src/pages/chat/widget/message_card.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class MessageList extends StatelessWidget {
  const MessageList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final chatController = Modular.get<ChatController>();

    return Obx(() => 
      ListView.builder(
        reverse: true,
        padding: EdgeInsets.only(left: 14, right: 14),
        itemCount: chatController.messagesList.length,
        itemBuilder: (context, index){
          return Message(
            model: chatController.messagesList[index],
          );
        }
      ),
    );
  }
}