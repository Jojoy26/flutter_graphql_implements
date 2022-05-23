import 'dart:io';

import 'package:flutter_gameplay/src/models/game_model.dart';
import 'package:flutter_gameplay/src/utils/format_number.dart';
import 'package:get/get.dart';

import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:flutter_gameplay/src/utils/months_list.dart';
import 'package:graphql/client.dart';

import 'mixins/snack_bar.dart';

class BookMatchController extends GetxController with SnackBar {

  final UserController userController;
  final GraphQLClientHelper clientHelper;
  BookMatchController({
    required this.userController,
    required this.clientHelper,
  });

  RxInt gameSelected = (1 * -1).obs;
  RxString date = "".obs;
  RxString time = "".obs;
  RxString title = "".obs;
  RxString description = "".obs;
  RxInt typeCardSelected = (1 * -1).obs;


  RxList<GameModel> gamesList = <GameModel>[].obs;
  RxBool gamesIsLoading = false.obs;

  void selectGame(int id) {
    gameSelected.value = id;
  }

  Future createMatch() async {

    if(!validateAll()){
      return;
    }
    
    final replacedDate = date.replaceAll("/", "");
    final replacedTime = time.replaceAll(":", "");

    final day = int.parse(replacedDate.substring(0, 2));
    final month = int.parse(replacedDate.substring(2, 4));


    final hour = int.parse(replacedTime.substring(0, 2));
    final minutes = int.parse(replacedTime.substring(2, 4));

    DateTime matchDate = DateTime.parse(
      "2022-${formatNumber(month)}-${formatNumber(day)} ${formatNumber(hour)}:${formatNumber(minutes)}:00"
      );
    
    final createMatchMutation = gql(r'''
     mutation($match: MatchInput) {
        action: createMatch(match: $match) {
          id,
          title,
          description
        }
      }
    ''');

    final MutationOptions options = MutationOptions(
      document: createMatchMutation,
      variables: <String, dynamic>{
        'match': {
          "title": title.value,
          "description": description.value,
          "gameId": gamesList[gameSelected.value].id,
          "date": matchDate.millisecondsSinceEpoch.toString(),
          "createdBy": userController.user.id,
          "typeMatch": typeCardSelected.value
        }
      },
    );

    final QueryResult result = await clientHelper.client.mutate(options);

    if(result.hasException){
      errorSnackBar("Falha ao criar partida");
    } else {
      sucessSnackBar("Partida criada com sucesso");
    }
  }

  Future getGames() async {
    gamesIsLoading.value = true;
    final gamesQuery = gql(r'''
      query {
        games {
          id,
          name,
          image,
          background_image
        }
      }
    ''');

    final QueryOptions options = QueryOptions(
      document: gamesQuery,
    );

    final QueryResult result = await clientHelper.client.query(options);
    
    if(!result.hasException){
      gamesList.value = (result.data?["games"] as List).map((item) {
        return GameModel.fromMap(item);
      }).toList();
    }
    
    gamesIsLoading.value = false;
  }

  bool validateAll() {

    if(typeCardSelected.value == -1){
      errorSnackBar("Selecione um tipo de partida");
      return false;
    }

    if(!validateGame()){
      return false;
    }

    if(!validateDate()){
      return false;
    }
    if(!validateTime()){
      return false;
    }

    if(title.value == ""){
      errorSnackBar("Digite um título");
      return false;
    }

    return true;
  }

  bool validateGame(){
    if(gameSelected.value < 0){
      errorSnackBar("Selecione um jogo");
      return false;
    } else {
      return true;
    }
  }

  bool validateDate() {
    bool hasError = false;
    if(date.value.length < 5){
      errorSnackBar("Digite uma data válida");
      return false;
    }
    var replacedDate = date.value.replaceAll("/", "");
    var day = int.parse(replacedDate.substring(0, 2));
    var month = int.parse(replacedDate.substring(2, 4));
    if(day > 31){
      hasError = true;
    }
    if(month == 1 && day > 28){
      hasError = true;
    }
    if(!monthsEqualTo31.contains(month) && day > 30){
      hasError = true;
    } else if(monthsEqualTo31.contains(month) && day > 31){
      hasError = true;
    }

    if(hasError){
      errorSnackBar("Digite uma data válida");
      return false;
    }
    return true;
  }

  bool validateTime() {

    bool hasError = false;

    if(time.value.length < 5){
      errorSnackBar("Digite um horário válido");
      return false;
    }

    var timeSplit = time.value.replaceAll(":", "");
    var hour = int.parse(timeSplit.substring(0, 2));
    var minute = int.parse(timeSplit.substring(2, 4));

    if(hour > 24){
      hasError = true;
    }
    if(minute > 60){
      hasError = true;
    }

    if(hasError){
      errorSnackBar("Digite um horário válido");
      return false;
    }

    return true;
  }

}
