import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator_en_jp_id/translator/translator_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslatorController translatorController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation History"),
      ),
      body: ListView.builder(
        itemCount: translatorController.translationHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: IconButton(
              onPressed: () => debugPrint("Delete histori ${index + 1}"),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
            title: Text(
              translatorController.translationHistory[index][1].toString(),
            ),
            subtitle: Text(
              translatorController.translationHistory[index][0].toString(),
            ),
          );
        },
      ),
    );
  }
}
