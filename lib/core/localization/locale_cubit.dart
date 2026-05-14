import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LocaleCubit extends Cubit<Locale> {
  final Box _prefsBox;
  static const _localeKey = 'app_locale';

  LocaleCubit(this._prefsBox) : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() {
    final langCode = _prefsBox.get(_localeKey, defaultValue: 'en') as String;
    emit(Locale(langCode));
  }

  Future<void> changeLanguage(String languageCode) async {
    await _prefsBox.put(_localeKey, languageCode);
    emit(Locale(languageCode));
  }
  
  Future<void> toggleLanguage() async {
    final newCode = state.languageCode == 'en' ? 'ar' : 'en';
    await changeLanguage(newCode);
  }
}
