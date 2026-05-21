import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _localeKey = 'app_locale';

  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() {
    final langCode = Hive.box('prefs_box').get(_localeKey, defaultValue: 'en');
    Intl.defaultLocale = langCode;
    emit(Locale(langCode));
  }

  Future<void> changeLanguage(String languageCode) async {
    await Hive.box('prefs_box').put(_localeKey, languageCode);
    Intl.defaultLocale = languageCode;
    emit(Locale(languageCode));
  }
  
  Future<void> toggleLanguage() async {
    final newCode = state.languageCode == 'en' ? 'ar' : 'en';
    await changeLanguage(newCode);
  }
}
