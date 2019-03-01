
import 'package:flutter/material.dart';
import 'package:hifidelity/services/localization/localization_service.dart';

class AppInheritedWidget extends InheritedWidget {
  final LocalizationService localization;
  final VoidCallback valueChanged;

  const AppInheritedWidget({
    Key key,
    @required this.localization,
    @required this.valueChanged,
    @required Widget child,
  }) : assert(localization != null),
       assert(valueChanged != null),
       super(key: key, child: child);

  static AppInheritedWidget of(BuildContext cxt) {
    return cxt.inheritFromWidgetOfExactType(AppInheritedWidget);
  }

  @override
  bool updateShouldNotify(AppInheritedWidget oldWidget) 
    => localization.languageCode != localization.oldLanguageCode;

  // Localization Convenience Methods
  get languageCode => localization.languageCode;
  set languageCode(String languageCode) {
    localization.languageCode = languageCode;
    valueChanged();
  }

  Language get language => localization.getCurrentLanguage();
  String text(String label, {String category}) => localization.text(label, category: category);
  String currency(num value) => localization.currency(value);
  Iterable<Language> getLanguages() => localization.getSupportedLanguages();

  // Scaling Convenience Methods
  // double get scaleRatio => scaling.scaleRatio;
  // set scaleRatio(double scale) {
  //   scaling.scaleRatio = scale;
  //   valueChanged();
  // }

  // double normalizeDimension(double dimension, {double minimum, double maximum}) => scaling.normalizeDimension(dimension, minimum: minimum, maximum: maximum);
  // double normalizeDimensionUnscaled(double dimension, {double minimum, double maximum}) => scaling.normalizeDimensionUnscaled(dimension, minimum: minimum, maximum: maximum);
  // double normalizeFontSize([double baseSize = ScalingService.normalFontSize, double minimum, double maximum]) => scaling.normalizeFontSize(baseSize, minimum, maximum);
  // double normalizeFontSizeUnscaled([double baseSize = ScalingService.normalFontSize, double minimum, double maximum]) => scaling.normalizeFontSizeUnscaled(baseSize, minimum, maximum);
  // double normalizeIconSize([double baseSize = ScalingService.normalIconSize, double minimum, double maximum]) => scaling.normalizeIconSize(baseSize, minimum, maximum);
  // double normalizeIconSizeUnscaled([double baseSize = ScalingService.normalIconSize, double minimum, double maximum]) => scaling.normalizeIconSizeUnscaled(baseSize, minimum, maximum);
}