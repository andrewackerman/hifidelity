import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/screens/register/pages/info_page.dart';
import 'package:hifidelity/screens/register/pages/password_page.dart';
import 'package:hifidelity/screens/register/pages/start_page.dart';
import 'package:hifidelity/screens/register/pages/success_page.dart';
import 'package:hifidelity/screens/register/pages/verify_page.dart';
import 'package:hifidelity/screens/register/pages/wallet_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({ GlobalKey key }) : super(key: key);

  @override
  State createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void pop() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  void drawerLanguageButtonPressed() {
    _scaffoldKey.currentState.openEndDrawer();
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
            children: [
              buildLanguageButton(cxt),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    hintColor: Colors.white,
                  ),
                  child: Navigator(
                    initialRoute: 'register/start',
                    onGenerateRoute: (RouteSettings settings) {
                      WidgetBuilder builder;
                      switch (settings.name) {
                        case 'register/start':
                          builder = (_) => StartPage();
                          break;
                        case 'register/info':
                          builder = (_) => InfoPage();
                          break;
                        case 'register/verify':
                          builder = (_) => VerifyPage();
                          break;
                        case 'register/password':
                          builder = (_) => PasswordPage();
                          break;
                        case 'register/wallet':
                          builder = (_) => WalletPage();
                          break;
                        case 'register/success':
                          builder = (_) => SuccessPage(widget.key);
                          break;
                        default:
                          throw Exception('Invalid route: ${settings.name}');
                      }
                      return MaterialPageRoute(builder: builder, settings: settings);
                    },
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