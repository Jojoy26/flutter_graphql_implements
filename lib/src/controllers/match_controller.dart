import 'dart:async';

import 'package:flutter_gameplay/src/controllers/mixins/snack_bar.dart';
import 'package:flutter_gameplay/src/models/match_model.dart';
import 'package:flutter_gameplay/src/models/user_model.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';

class MatchController extends GetxController with SnackBar {

  final GraphQLClientHelper clientHelper;
  final UserController userController;

  MatchController({
    required this.clientHelper,
    required this.userController,
  });

  UserModel get user => userController.user;

  Rx<MatchModel?> match = null.obs;
  RxList<UserModel> usersList = <UserModel>[].obs;

  late StreamSubscription sub;

  void goToChat() {
    Get.toNamed("/chat", arguments: match.value!.chatId);
  }

  void backToHome() {
    Get.back();
  }

  void dispose() {
    sub.cancel();
  }

  Future joinMatch() async {

    final joinMatchMutation = gql(
      r'''
        mutation($input: JoinMatchInput) {
          action: joinMatch(input: $input)
        }
      '''
    );

    final MutationOptions options = MutationOptions(
      document: joinMatchMutation,
      variables: <String, dynamic>{
        'input': {
          "userId": user.id,
          "matchId": match.value?.id
        },
      },
    );

    final QueryResult result = await clientHelper.client.mutate(options);
    
    if (result.hasException) {
      errorSnackBar("Erro ao entrar no servidor");
    } else {
      sucessSnackBar("Entrou no servidor com sucesso");
      match.update((val) {
        val!.isInTheGroup = true;
      });
    }

  }

  Future getUsers() async {

    final usersSubscription = gql(
      r'''
        subscription($matchId: Int) {
          matchUsers(matchId: $matchId) {
            id,
            users {
              id,
              username,
              profile_image,
              status
            }
          }
        }
      ''',
    );

    final subscription = clientHelper.client.subscribe(
      SubscriptionOptions(
        document: usersSubscription,
        variables: {
          "matchId": match.value!.id
        }
      )
    );

    sub = subscription.listen((event) {
      print(event.data?["matchUsers"]["users"]);
      usersList.value = (event.data?["matchUsers"]["users"] as List).map((e) => UserModel.fromServerMap(e)).toList();
    });
    
  }

}
