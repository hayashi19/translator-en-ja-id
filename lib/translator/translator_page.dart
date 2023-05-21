import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translator_controller.dart';

class TranslationPage extends StatelessWidget {
  const TranslationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const <Widget>[
          TranslationTextfield(),
          TranslationToolBar(),
          TranslatedTextfield(),
          // Test()
        ],
      ),
    );
  }
}

class TranslationTextfield extends StatelessWidget {
  const TranslationTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslatorController translatorController = Get.find();
    return Container(
      color: Colors.grey.shade800,
      child: TextField(
        controller: translatorController.translationTextfield.value,
        minLines: 5,
        maxLines: 5,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(16),
          hintText: "type the words you want to be translated . . .",
        ),
        onChanged: (value) => translatorController.doTranslation(value),
      ),
    );
  }
}

class TranslationToolBar extends StatelessWidget {
  const TranslationToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          onPressed: () => debugPrint("Mic On"),
          icon: const Icon(Icons.mic_rounded),
        ),
        IconButton(
          onPressed: () => debugPrint("Camera"),
          icon: const Icon(Icons.camera_alt_rounded),
        ),
      ],
    );
  }
}

class TranslatedTextfield extends StatelessWidget {
  const TranslatedTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslatorController translatorController = Get.find();
    return Ink(
      color: Colors.grey.shade800,
      child: TextField(
        controller: translatorController.translatedTextfield.value,
        minLines: 5,
        maxLines: 5,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintText: "the translated word . . .",
          icon: IconButton(
            onPressed: () => debugPrint("Copy"),
            icon: const Icon(Icons.copy_all_rounded),
          ),
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslatorController translatorController = Get.find();
    return ElevatedButton(
      onPressed: () {
        translatorController.downloadModels();
      },
      child: const Text("Hello"),
    );
  }
}
