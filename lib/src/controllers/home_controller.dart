import 'package:flutter_gameplay/src/models/match_model.dart';
import "package:socket_io_client/socket_io_client.dart";
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:flutter_gameplay/src/models/user_model.dart';

class HomeController extends GetxController {

  final UserController userController;
  final GraphQLClientHelper clientHelper;
  HomeController({
    required this.userController,
    required this.clientHelper,
  });

  UserModel get user => userController.user;

  RxInt typeSelected = (1 * -1).obs;
  RxList<MatchModel> matchList = <MatchModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;

  void goToBookMatch() {
    Get.toNamed("/bookmatch");
  }

  void changeUserStatus() {
    try{
      var socket = io('http://192.168.0.106:3000', 
      OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect()  // disable auto-connection
        .enableReconnection()
        .setReconnectionDelay(10)
        .setExtraHeaders({'foo': 'bar',"Accept": "application/json", "userId": user.id})
        .build()
      );
      socket.connect().onConnectError((data) => print("error on connect to socket"));  
    } catch(e){
      print(e);
    }
  }

  void goToMatch(int index) {
    Get.toNamed("/match", arguments: matchList[index]);
  }

  Future getMatchs() async {
    isLoading.value = true;
    hasError.value = false;

    var matchsQuery = gql(
      r'''
        query($getMatchsInput: GetMatchsInput) {
          matchs(getMatchsInput: $getMatchsInput) {
            chatId,
            createdBy,
            date,
            description,
            id,
            title,
            typeMatch,
            isInTheGroup
            game {
              id,
              name,
              image,
              background_image
            }
            users {
              id,
              username,
              profile_image,
              status
            }
          }
        }
      '''
    );

    late QueryOptions options;

    if(typeSelected.value == -1 ){
      options = QueryOptions(
        document: matchsQuery,
        variables: {
          "getMatchsInput": {
            "userId": user.id
          }
        }
      );
    } else {
      options = QueryOptions(
        document: matchsQuery,
        variables: {
          "getMatchsInput": {
            "typeMatch": typeSelected.value,
            "userId": user.id
          }
        }
      );
    }

    final QueryResult result = await clientHelper.client.query(options);

    if(result.hasException){
      print(result.exception);
      hasError.value = true;
      isLoading.value = false;
      return;
    }

    matchList.value = (result.data?["matchs"] as List).map((item) {
      return MatchModel.fromMap(item);
    }).toList();

    isLoading.value = false;
  }

}
