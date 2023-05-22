import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator_en_jp_id/main_controller.dart';

import 'translator/translator_controller.dart';
import 'translator/translator_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
  Get.put(TranslatorController());
  runApp(const MainApp());
}

class MainApp extends GetView<MainController> {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.dark(), home: const TranslationPage());
  }
}
