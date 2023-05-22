import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_translate/learning_translate.dart';

class TranslatorController extends GetxController {
  Timer? _debounceTimer;

  var translationTextfield = TextEditingController().obs;
  var translatedTextfield = TextEditingController().obs;

  var tFromList = [].obs;
  var selectedFrom = 'id'.obs;
  var tToList = [].obs;
  var selectedTo = 'en'.obs;

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
    await TranslationModelManager.check(INDONESIAN)
        .then((isIndonesiaDownloaded) async {
      if (!isIndonesiaDownloaded) {
        await TranslationModelManager.download(INDONESIAN);
      } else {
        await TranslationModelManager.check(ENGLISH)
            .then((isEnglishDownloaded) async {
          if (!isEnglishDownloaded) {
            await TranslationModelManager.download(ENGLISH);
          } else {
            await TranslationModelManager.check(JAPANESE)
                .then((isJapaneseDownloaded) async {
              if (!isJapaneseDownloaded) {
                await TranslationModelManager.download(JAPANESE);
              }
            });
          }
        });
      }
    });

    tFromList.value = await TranslationModelManager.list();
    tToList.value = await TranslationModelManager.list();
  }

  Future setTranslator() async {
    translator = Translator(from: selectedFrom.value, to: selectedTo.value);
  }

  @override
  void onInit() {
    downloadModels();
    super.onInit();
  }

  @override
  void dispose() {
    translator.dispose();
    super.dispose();
  }
}
