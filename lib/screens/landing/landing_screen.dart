import 'package:flutter/material.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/screens/landing/components/login_page.dart';
import 'package:hifidelity/screens/landing/components/register_page.dart';
import 'package:hifidelity/services/localization/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LandingScreen extends StatefulWidget {
  @override
  State createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  PageController _pageController = PageController();
  int _currentPage = 0;

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

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  existingUserPressed() {
    setState(() {
      _currentPage = 0;
      _pageController.jumpToPage(0);
    });
  }

  newUserPressed() {
    setState(() {
      _currentPage = 1;
      _pageController.jumpToPage(1);
    });
  }

  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: LocalizationDrawer(),
      body: Ink(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => _drawerLanguageButtonClicked(cxt),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Text(
                              Localization.getCurrentLanguage().displayCode, 
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationStyle: TextDecorationStyle.dotted,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, right: 12),
                              child: Icon(MdiIcons.earth, color: Colors.white, size: 32),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Image.asset(
                    'assets/images/large_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _currentPage == 0 ? null : existingUserPressed,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentPage == 0 ? Colors.grey[200] : Colors.grey[800],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        child: Text(
                          Localization.text('ExistingUser', category: 'landing'),
                          style: TextStyle(
                            color: _currentPage == 0 ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: _currentPage == 0 ? TextDecoration.none : TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _currentPage == 1 ? null : newUserPressed,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentPage == 1 ? Colors.grey[200] : Colors.grey[800],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        child: Text(
                          Localization.text('NewUser', category: 'landing'),
                          style: TextStyle(
                            color: _currentPage == 1 ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: _currentPage == 1 ? TextDecoration.none : TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                flex: 7,
                child: PageView(
                  controller: _pageController,
                  children: [
                    LoginPage(),
                    RegisterPage(),
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