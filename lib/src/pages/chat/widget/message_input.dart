import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final chatController = Modular.get<ChatController>();

    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              child: TextField(
                controller: chatController.messageController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15, right: 15),
                  hintText: "Mensagem",
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: IconButton(
              color: Color(0xFF0E1647),
              onPressed: (){
                chatController.createMessage();
              }, 
              icon: Icon(Icons.add)
            ),
          )
        ],
      ),
    );
  }
}