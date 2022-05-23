
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin SnackBar {
  void errorSnackBar(String message){
    Get.snackbar(
      "Error", 
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }

  void sucessSnackBar(String message) {
    Get.snackbar(
      "Sucesso", 
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      backgroundColor: Colors.green,
      colorText: Colors.white
    );
  }
} 