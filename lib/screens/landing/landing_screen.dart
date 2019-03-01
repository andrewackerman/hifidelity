import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LandingScreen extends StatefulWidget {
  @override
  State createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void drawerLanguageButtonPressed() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void loginButtonPressed() {
    Navigator.of(context).pushReplacementNamed('dashboard');
  }

  void registerButtonPressed() {
    Navigator.of(context).pushReplacementNamed('register');
  }

  Widget buildLanguageButton(BuildContext cxt) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: drawerLanguageButtonPressed,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Text(
                    AppInheritedWidget.of(cxt).language.displayCode, 
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
    );
  }

  Widget buildLoginSection(BuildContext cxt) {
    return Theme(
      data: ThemeData(
        hintColor: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              AppInheritedWidget.of(cxt).text('LoginText', category: 'login'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Text(
              AppInheritedWidget.of(cxt).text('LoginSubtext', category: 'login'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child:  TextField(
                decoration: InputDecoration(
                  hintText: AppInheritedWidget.of(cxt).text('Email', category: 'login'),
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child:  TextField(
                decoration: InputDecoration(
                  hintText: AppInheritedWidget.of(cxt).text('Password', category: 'login'),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
            ),
          ),
          Expanded(child: Container()),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: RaisedButton(
                onPressed: loginButtonPressed,
                child: Text(AppInheritedWidget.of(cxt).text('Login', category: 'login')),
              ),
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
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
              buildLanguageButton(cxt),
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
              Expanded(
                flex: 7,
                child: buildLoginSection(cxt),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        AppInheritedWidget.of(cxt).text('DontHaveLogin', category: 'register'),
                        style:TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.4,
                        child: RaisedButton(
                          onPressed: registerButtonPressed,
                          child: Text(AppInheritedWidget.of(cxt).text('Register', category: 'register')),
                        ),
                      ),
                    ],
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