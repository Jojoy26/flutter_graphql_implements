import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_client.dart';

import 'package:flutter_gameplay/src/controllers/mixins/snack_bar.dart';
import 'package:flutter_gameplay/src/controllers/user_controller.dart';
import 'package:flutter_gameplay/src/graphql/graphql_client.dart';
import 'package:flutter_gameplay/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with SnackBar {

  final Dio dio;
  final UserController userController;
  final GraphQLClientHelper clientHelper;

  LoginController({
    required this.dio,
    required this.userController,
    required this.clientHelper,
  });

  RxBool isLoading = false.obs;

  // Trying login
  Future login(String? token) async{
    
    // Getting token from splash screen
    // If token is equal to null, make a new request to get another token
    try {

      late String userToken;

      if(token == null){
        MyOAuth2Client auth = MyOAuth2Client(
          redirectUri: "my.test.app://oauth2",
          customUriScheme: "my.test.app"
        );

        AccessTokenResponse response = await auth.getTokenWithAuthCodeFlow(
          clientId: "953288776828997642",
          clientSecret: "t0jM4TXo2kMNPW63MDqfV3wAWU8bWkW7",
          scopes: ["identify"]
        );
        userToken = response.accessToken as String;
      } else {
        userToken = token;
      }

      isLoading.value = true;

      await Future.delayed(Duration(seconds: 2));
      await getUserInfos(userToken);

      isLoading.value = false;
    } catch(e){
      errorSnackBar("Erro ao fazer login");
      isLoading.value = false;
    }
    
  }


  Future getUserInfos(String token) async {

    // Getting user infos from discord
    final result = await dio.get("https://discord.com/api/users/@me", options: Options(
      headers: {"Authorization": "Bearer ${token}"}
    ));
    final user = UserModel.fromDiscordMap(result.data);
    userController.setUser(user);

    // Saving user discord token
    await saveToken(token);
    // Saving user infos in BD
    await saveUserInfos(user);
  }

  Future saveUserInfos(UserModel model) async {
    
    try{

      final addUser = gql(
        r'''
          mutation($user: UserInput) {
            action: addUser(user: $user) {
              id,
              username,
              profile_image
            }
          }
        ''',
      );
      final MutationOptions options = MutationOptions(
        document: addUser,
        variables: <String, dynamic>{
          'user': model.toMap()
        },
      );

      final QueryResult result = await clientHelper.client.mutate(options);
      if(!result.hasException){
        Get.offAllNamed("/home");
        return;
      }
      errorSnackBar("Erro ao fazer login");
    } catch(e){
      errorSnackBar("Erro ao fazer login");
    }
  }

  Future saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("tokenGameplay", token);
  }

}

class MyOAuth2Client extends OAuth2Client {
  MyOAuth2Client({required String redirectUri, required String customUriScheme}): super(
    authorizeUrl: 'https://discord.com/api/oauth2/authorize',
    tokenUrl: 'https://discord.com/api/oauth2/token', 
    redirectUri: redirectUri,
    customUriScheme: customUriScheme
  );
}