import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/chat_controller.dart';
import 'package:flutter_gameplay/src/pages/chat/widget/message_input.dart';
import 'package:flutter_gameplay/src/pages/chat/widget/message_list.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  int chatId = Get.arguments;

  final controller = Modular.get<ChatController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.chatId = chatId;
    controller.getMessages();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    Modular.dispose<ChatController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1647).withOpacity(0.8),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat"),
        backgroundColor: Color(0xFF1D2766)
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList()
          ),
          MessageInput()
        ],
      ),
    );
  }
}