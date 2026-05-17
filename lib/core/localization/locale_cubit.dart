import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  final Map<String, dynamic> _prefsBox;
  static const _localeKey = 'app_locale';

  LocaleCubit(this._prefsBox) : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() {
    final langCode = _prefsBox[_localeKey] as String? ?? 'en';
    emit(Locale(langCode));
  }

  Future<void> changeLanguage(String languageCode) async {
    _prefsBox[_localeKey] = languageCode;
    emit(Locale(languageCode));
  }
  
  Future<void> toggleLanguage() async {
    final newCode = state.languageCode == 'en' ? 'ar' : 'en';
    await changeLanguage(newCode);
  }
}
