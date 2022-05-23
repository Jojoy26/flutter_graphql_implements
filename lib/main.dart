import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gameplay/app_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_module.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ModularApp(module: AppModule(), child: AppWidget())
  );
}
