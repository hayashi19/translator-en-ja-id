import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_translate/learning_translate.dart';

class TranslatorController extends GetxController {
  Timer? _debounceTimer;

  var translationTextfield = TextEditingController().obs;
  var translatedTextfield = TextEditingController().obs;

  var translationHistory = <List>[<String>[]].obs;

  Translator translator = Translator(from: INDONESIAN, to: ENGLISH);

  void doTranslation(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      String translatedText = await translator.translate(value);
      if (value.isNotEmpty) {
        translatedTextfield.value.text = translatedText;
        addToTranslationHistory(value, translatedText);
        if (translationHistory.isNotEmpty) {
          translationHistory.removeWhere((list) => list.isEmpty);
        }
      } else {
        translatedTextfield.value.text = "";
      }
    });
  }

  void addToTranslationHistory(String originalText, String translatedText) {
    translationHistory.add([originalText, translatedText]);
  }

  Future<void> downloadModels() async {
    bool isIndonesiaDownloaded =
        await TranslationModelManager.check(INDONESIAN);
    bool isEnglishDownloaded = await TranslationModelManager.check(ENGLISH);
    bool isJapaneseDownloaded = await TranslationModelManager.check(JAPANESE);

    if (!isIndonesiaDownloaded) {
      await TranslationModelManager.download(INDONESIAN);
    } else if (!isEnglishDownloaded) {
      await TranslationModelManager.download(ENGLISH);
    } else if (!isJapaneseDownloaded) {
      await TranslationModelManager.download(JAPANESE);
    }

    await TranslationModelManager.download(INDONESIAN)
        .then((value) => value.toString().printInfo());
    await TranslationModelManager.download(ENGLISH)
        .then((value) => value.toString().printInfo());
    await TranslationModelManager.download(JAPANESE)
        .then((value) => value.toString().printInfo());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    downloadModels();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    translator.dispose();
    super.dispose();
  }
}
