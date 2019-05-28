import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/services/localization/localization_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LocalizationDrawer extends StatelessWidget {
  _languageOptionPressed(BuildContext cxt, Language lang) {
    // print('${lang.name} pressed.');
    AppInheritedWidget.of(cxt).languageCode = lang.key;
    Navigator.of(cxt).pop();
  }

  @override
  Widget build(BuildContext cxt) {
    Widget buildOption(String text, String caption, VoidCallback callback) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: InkWell(
          onTap: callback,
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: 36,
              ),
              children: [
                TextSpan(
                  text: caption,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                TextSpan(text: ' '),
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationStyle: TextDecorationStyle.dotted,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final languages = AppInheritedWidget.of(cxt).getLanguages();
    final options = <Widget>[];
    for (var lang in languages) {
      // options.add(buildOption(lang['name'], (lang['code'] as String).toUpperCase(), () => print('${lang['name']} tapped.')));
      options.add(buildOption(
          lang.name, lang.code, () => _languageOptionPressed(cxt, lang)));
    }

    return Drawer(
      child: Ink(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_1.png'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Color.fromARGB(255, 7, 70, 127),
                  child: Center(
                    child: Transform.rotate(
                      angle: Math.pi / 2,
                      child: Icon(
                        MdiIcons.menu,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16, top: 16, bottom: 50),
                      child: InkWell(
                        onTap: () => Navigator.of(cxt).pop(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                AppInheritedWidget.of(cxt).text('Close'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Icon(MdiIcons.arrowRight, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: options),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
