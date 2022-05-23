import 'package:flutter/material.dart';
import 'package:flutter_gameplay/src/controllers/chat_controller.dart';
import 'package:flutter_gameplay/src/utils/format_number.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gameplay/src/models/message_model.dart';

class Message extends StatelessWidget {
  final MessageModel model;

  const Message({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ChatController chatController = Modular.get<ChatController>();

    bool isMine = chatController.user.id == model.user.id;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !isMine,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(model.user.profileImage),
              ),
            ),
            Visibility(
              visible: !isMine,
              child: SizedBox(width: 10,)
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60
              ),
              padding: EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 5),
              decoration: BoxDecoration(
                color: isMine ? Color(0xFFDCF8C6) : Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.user.username,
                    style: GoogleFonts.roboto(
                      color: Color(0xFF0E1647),
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    model.message,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey[900]
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height: 3,),
                  Flexible(
                    child: Text(
                      "${formatNumber(model.createdAt.hour)}:${formatNumber(model.createdAt.minute)}",
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isMine,
              child: SizedBox(width: 10,)
            ),
            Visibility(
              visible: isMine,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(model.user.profileImage),
              ),
            )
          ],
        ),
      ),
    );
  }
}
