import 'package:flutter/material.dart';
import 'package:myproject/utils/utility.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _locale = const Locale('th');
  Locale get locale => _locale;

  // Constructor
  LocaleProvider(Locale locale) {
    _locale = locale;
  }

  // Change Locale
  void changeLocale(Locale newLocale) async {
    _locale = newLocale;
    await Utility.setSharedPreference("localeLanguageCode",newLocale.languageCode);
    notifyListeners();
  }

}