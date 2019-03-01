import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationDrawer extends StatelessWidget {
  void dashboardPressed(BuildContext cxt) {
    final nav = Navigator.of(cxt);
    nav.pop();
    nav.pushReplacementNamed('dashboard');
  }

  void settingsPressed(BuildContext cxt) {
    final nav = Navigator.of(cxt);
    nav.pop();
    nav.pushReplacementNamed('settings');
  }

  void logOutPressed(BuildContext cxt) {
    final nav = Navigator.of(cxt);
    nav.pop();
    nav.pushReplacementNamed('/');
  }

  Widget buildOption(String text, VoidCallback callback) {
      return Padding(
        padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
        child: InkWell(
          onTap: callback,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w100,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.white,
            ),
          ),
        ),
      );
    }

    @override
    Widget build(BuildContext cxt) {
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
                  flex: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, bottom: 50),
                        child: InkWell(
                          onTap: () => Navigator.of(cxt).pop(),
                          child: Row(
                            children: [
                              Icon(MdiIcons.arrowLeft, color: Colors.white),
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
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      buildOption(AppInheritedWidget.of(cxt).text('Dashboard', category: 'overview'), () => dashboardPressed(cxt)),
                      buildOption(AppInheritedWidget.of(cxt).text('Settings', category: 'overview'), () => settingsPressed(cxt)),
                      Expanded(child: Container()),
                      buildOption(AppInheritedWidget.of(cxt).text('LogOut', category: 'overview'), () => logOutPressed(cxt)),
                      Expanded(flex: 2, child: Container()),
                    ],
                  ),
                ),
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
              ],
            ),
          ),
        ),
      );
    }
}