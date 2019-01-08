import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:hifidelity/components/gradient_raised_button.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/components/navigation_drawer.dart';
import 'package:hifidelity/screens/home/components/deal_carousel.dart';
import 'package:hifidelity/services/localization/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hifidelity/components/gradient_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    Localization.addListener(localeChanged);
    super.initState();
  }

  @override
  void dispose() {
    Localization.removeListener(localeChanged);
    super.dispose();
  }

  void localeChanged(Locale newLocale) {
    setState(() {});
  }

  // void _drawerMenuButtonClicked(BuildContext cxt) {

  // }

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  Widget tokensOwnedBar(BuildContext cxt) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 246, 246),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(2, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '7000',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromARGB(255, 16, 65, 131),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              Localization.text('TokensOwned', category: 'overview'),
              style: TextStyle(
                color: Color.fromARGB(255, 100, 100, 100),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tokenProgressBar(BuildContext cxt) {
    return Container(
      // color: Color.fromARGB(255, 16, 65, 131),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 13, 55, 111),
            Color.fromARGB(255, 16, 65, 131),
            Color.fromARGB(255, 16, 65, 131),
            Color.fromARGB(255, 13, 55, 111),
          ],
          stops: [
            0.02,
            0.05,
            0.95,
            0.98,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Localization.text('Level4', category: 'overview'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  )
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(cxt).style.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                    children: Localization.getCurrentLanguage().code == 'ja-JP'
                    ? [
                      TextSpan(text: Localization.text('Level5', category: 'overview'), style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: Localization.text('TokensUntil', category: 'overview')),
                      TextSpan(text: '777', style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                    : [
                      TextSpan(text: '777', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: Localization.text('TokensUntil', category: 'overview')),
                      TextSpan(text: Localization.text('Level5', category: 'overview'), style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GradientProgressIndicator(value: 0.75),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientRaisedButton(
                  width: 160,
                  height: 35,
                  onPressed: () {},
                  child: Text(
                    Localization.text('SeeAllBenefits', category: 'overview'),
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 65, 131),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment(-0.02, -1),
                    end: Alignment(0.02, 1),
                    colors: [
                      Colors.white,
                      Color.fromARGB(255, 212, 223, 236),
                    ],
                    stops: [
                      0.69,
                      0.71,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dealCarouselBar(BuildContext cxt) {
    return Container(
      color: Color.fromARGB(255, 249, 249, 249),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                Localization.text('CurrentDeals', category: 'overview'),
                style: TextStyle(
                  color: Color.fromARGB(255, 15, 65, 131),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: DealCarousel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 153, 184),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Center(child: Image.asset('assets/images/7tk_title.png')),
        ),
        actions: [
          InkWell(
            onTap: () => _drawerLanguageButtonClicked(cxt),
            child: Row(
              children: [
                Text(Localization.getCurrentLanguage().displayCode),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 12),
                  child: Icon(MdiIcons.earth, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: tokensOwnedBar(cxt),
            ),
            Expanded(
              flex: 8,
              child: tokenProgressBar(cxt),
            ),
            Expanded(
              flex: 26,
              child: dealCarouselBar(cxt),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
      endDrawer: LocalizationDrawer(),
    );
  }
}