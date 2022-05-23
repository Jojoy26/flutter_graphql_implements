import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashController extends GetxController {

  Future getToken() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    String? token = preferences.getString("tokenGameplay");
    Get.offAllNamed("/login", arguments: token);
  }

}
