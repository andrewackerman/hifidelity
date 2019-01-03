import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart' as Intl;
import 'package:intl/intl.dart';

import './lang/en-US.dart' as enUS;
import './lang/ja-JP.dart' as jaJP;

const defaultLocale = Locale('en', 'US');

final langMap = {
  const Locale('en', 'US'): enUS.lang,
  const Locale('ja', 'JP'): jaJP.lang,
};

class Localization {
  static Locale _locale;
  static Locale get locale => _locale;

  static setLocale(Locale value) async {
    _locale = value;

    if (langMap[_locale] == null) {
      for (var key in langMap.keys) {
        if (key.languageCode == _locale.languageCode) {
          _locale = key;
          break;
        }
      }
    }

    await Intl.initializeDateFormatting(_locale.toString());
    print('Locale set to $_locale');
  }

  static Iterable<Map<String, dynamic>> getSupportedLanguages() {
    final langs = <Map<String, dynamic>> [];

    for (var lang in langMap.values) {
      langs.add({
        'code': lang['languageDisplayCode'],
        'name': lang['languageDisplayName'],
      });
    }

    return langs;
  }

  static Map<String, dynamic> getCurrentLanguage() {
    return {
      'code': langMap[_locale]['languageDisplayCode'],
      'name': langMap[_locale]['languageDisplayName'],
    };
  }

  static String text(String label, { String category }) {
    assert(label != null);

    var lang = langMap[_locale];
    if (lang == null) {
      print('[WARNING] Locale `$_locale` doesn\'t exist');
      lang = langMap[defaultLocale];
    }

    final categoryGroup = lang['entries'][category];
    if (categoryGroup == null) {
      print('[WARNING] Category `$category` doesn\'t exist in locale `$_locale`');
      return 'ERR_CATEGORY (${_locale}_$category)';
    }

    final text = categoryGroup[label];
    if (text == null) {
      print('[WARNING] Label `$label` doesn\'t exist in category `$category` in locale `$_locale`');
      return 'ERR_LABEL (${_locale}_${category}_$label)';
    }

    return text;
  }

  static String compactDate(DateTime date) {
    return DateFormat.yMd(_locale.toString()).format(date);
  }

  static String shortDate(DateTime date) {
    return DateFormat.yMMMMd(_locale.toString()).format(date);
  }

  static String longDate(DateTime date) {
    return DateFormat.yMMMMd(_locale.toString()).format(date);
  }

  static String number(num value) {
    return NumberFormat.decimalPattern(_locale.toString()).format(value);
  }
}