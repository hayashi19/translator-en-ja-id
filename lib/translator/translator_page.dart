import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator_en_jp_id/drawer/drawer_page.dart';

import 'translator_controller.dart';

class TranslationPage extends StatelessWidget {
  const TranslationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      appBar: AppBar(title: const LangSwitch()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: const <Widget>[
              TranslationTextfield(),
              TranslationToolBar(),
              TranslatedTextfield(),
              // Test()
            ],
          ),
        ),
      ),
    );
  }
}

class LangSwitch extends StatelessWidget {
  const LangSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslatorController translatorController = Get.find();

    return Obx(
      () {
        if (translatorController.tFromList.isEmpty ||
            translatorController.tToList.isEmpty) {
          return const Text("Download the models");
        } else {
          return Row(
            children: <Widget>[
              Expanded(
                child: Obx(
                  () => DropdownButton<String>(
                    isExpanded: true,
                    isDense: true,
                    value: translatorController.selectedFrom.value,
                    items: translatorController.tFromList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: value == "ja"
                            ? const Text("Japanese")
                            : value == "id"
                                ? const Text("Indonesia")
                                : const Text("English"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == translatorController.selectedTo.value) {
                        String temp = translatorController.selectedFrom.value;
                        translatorController.selectedFrom.value =
                            translatorController.selectedTo.value;
                        translatorController.selectedTo.value = temp;
                      } else {
                        translatorController.selectedFrom.value = value!;
                      }
                      translatorController.setTranslator();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.arrow_right_alt_rounded),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(
                  () => DropdownButton<String>(
                    isExpanded: true,
                    isDense: true,
                    value: translatorController.selectedTo.value,
                    items: translatorController.tToList.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: value == "ja"
                            ? const Text("Japanese")
                            : value == "id"
                                ? const Text("Indonesia")
                                : const Text("English"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == translatorController.selectedFrom.value) {
                        String temp = translatorController.selectedTo.value;
                        translatorController.selectedTo.value =
                            translatorController.selectedFrom.value;
                        translatorController.selectedFrom.value = temp;
                      } else {
                        translatorController.selectedTo.value = value!;
                      }
                      translatorController.setTranslator();
                    },
                  ),
                ),
              )
            ],
          );
        }
      },
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
        // translatorController.test();
      },
      child: Text(
        "${translatorController.translator.from} -> ${translatorController.translator.to}",
      ),
    );
  }
}
