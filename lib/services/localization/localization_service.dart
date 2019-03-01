import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart' as Intl;
import 'package:intl/intl.dart';

import './lang/en-US.dart' as enUS;
import './lang/ja-JP.dart' as jaJP;

const defaultLocale = Locale('en', 'US');

final langMap = {
  'en-US': enUS.lang,
  'ja-JP': jaJP.lang,
};

class LocalizationService {

  double get currencyModifier => langMap[languageCode]['currencyModifier'];

  String _oldLanguageCode;
  String get oldLanguageCode => _oldLanguageCode;

  String _languageCode;
  String get languageCode => _languageCode;
  set languageCode(String value) {
    _oldLanguageCode = _languageCode;
    _languageCode = value;

    Intl.initializeDateFormatting(_languageCode);
    print('Language code set to $_languageCode');
  }

  Iterable<Language> getSupportedLanguages() {
    return langMap.entries.map((e) => Language(
      key: e.key,
      name: e.value['languageDisplayName'], 
      code: e.value['languageCode'], 
      displayCode: e.value['languageDisplayCode'], 
    ));
  }

  Language getCurrentLanguage() {
    return Language(
      key: _languageCode,
      name: langMap[_languageCode]['languageDisplayName'], 
      code: langMap[_languageCode]['languageCode'],
      displayCode: langMap[_languageCode]['languageDisplayCode'],
    );
  }

  String text(String label, { String category }) {
    assert(label != null);

    var lang = langMap[_languageCode];
    if (lang == null) {
      print('[WARNING] Locale `$_languageCode` doesn\'t exist');
      lang = langMap[defaultLocale];
    }

    final categoryGroup = lang['text'][category];
    if (categoryGroup == null) {
      print('[WARNING] Category `$category` doesn\'t exist in locale `$_languageCode`');
      return 'ERR_CATEGORY (${_languageCode}_$category)';
    }

    final text = categoryGroup[label];
    if (text == null) {
      print('[WARNING] Label `$label` doesn\'t exist in category `$category` in locale `$_languageCode`');
      return 'ERR_LABEL (${_languageCode}_${category}_$label)';
    }

    return text;
  }

  String compactDate(DateTime date) {
    return DateFormat.yMd(_languageCode).format(date);
  }

  String shortDate(DateTime date) {
    return DateFormat.yMMMMd(_languageCode).format(date);
  }

  String longDate(DateTime date) {
    return DateFormat.yMMMMd(_languageCode).format(date);
  }

  String number(num value) {
    return NumberFormat.decimalPattern(_languageCode).format(value);
  }

  String currency(num value) {
    value *= currencyModifier;
    return NumberFormat.simpleCurrency(locale: _languageCode).format(value);
  }
}

class Language {
  final String key;
  final String name;
  final String code;
  final String displayCode;
  final Locale locale;

  Language({
    this.key,
    this.name,
    this.code,
    this.displayCode,
  }) : this.locale = Locale(key.substring(0, 2), key.substring(3, 5));
}