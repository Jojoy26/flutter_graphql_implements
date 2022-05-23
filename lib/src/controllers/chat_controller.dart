import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gameplay/src/controllers/mixins/snack_bar.dart';
import 'package:flutter_gameplay/src/models/message_model.dart';
import 'package:flutter_gameplay/src/models/user_model.dart';
import 'package:get/get.dart';

import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:graphql/client.dart';

class ChatController extends GetxController with SnackBar{

  final GraphQLClientHelper clientHelper;
  final UserController userController;
  ChatController({
    required this.clientHelper,
    required this.userController,
  });

  UserModel get user => userController.user;

  RxList<MessageModel> messagesList = <MessageModel>[].obs;
  TextEditingController messageController = TextEditingController();

  int chatId = 0;

  late StreamSubscription sub;

  void dispose() {
    sub.cancel();
  }

  Future createMessage() async {

    if(messageController.text == ""){
      errorSnackBar("Digite um mensagem");
    }

    final createMessageMutation = gql(
      r'''
        mutation($input: CreateMessageInput) {
          action: createMessage(input: $input)
        }
      '''
    );

    final MutationOptions options = MutationOptions(
      document: createMessageMutation,
      variables: <String, dynamic>{
        'input': {
          "chatId": chatId,
          "userId": user.id,
          "message": messageController.text
        }
      },
    );

    final QueryResult result = await clientHelper.client.mutate(options);

    if(result.hasException){
      errorSnackBar("Falha ao enviar mensagem");
    }

  }

  Future getMessages() async {

    final messagesSubscription = gql(
      r'''
        subscription($input: MessagesInput) {
          messages(input: $input) {
            id,
            createdAt,
            message,
            user {
              id,
              username,
              profile_image,
              status,
            }
          }
        }
      '''
    );

    final subscription = clientHelper.client.subscribe(
      SubscriptionOptions(
        document: messagesSubscription,
        variables: {
          "input": {
            "chatId": chatId,
          }
        }
      ),
    );

    sub = subscription.listen((event) {
      messagesList.value = (event.data?["messages"] as List).map((item) => MessageModel.fromMap(item)).toList();
    });
  }

}
