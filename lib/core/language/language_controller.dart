import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales/core/utils/shared_preference_helper.dart';

class LanguageController extends StateNotifier<Locale> {
  LanguageController() : super(Locale.fromSubtags(languageCode:(SharedPrefHelper.sp.getString('lang')??'ar')));

  void en() => state = const Locale.fromSubtags(languageCode: 'en');
  void ar() => state = const Locale.fromSubtags(languageCode: 'ar');
}

final languageProvider = StateNotifierProvider<LanguageController, Locale>(
      (ref) => LanguageController(),
);