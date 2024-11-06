import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'en_US.dart';
import 'id_ID.dart';

class TranslationService extends Translations {
  static Locale? get locale => const Locale('en', 'US');
  static const fallbackLocale = Locale('id', 'ID');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'id_ID': id_ID,
      };
}
