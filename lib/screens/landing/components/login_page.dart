import 'package:flutter/material.dart';
import 'package:hifidelity/services/localization/localization.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _loginButtonPressed(BuildContext cxt) {
    Navigator.of(cxt).pushNamed('/home');
  }

  @override
  Widget build(BuildContext cxt) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  Localization.text('LoginText', category: 'login'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  Localization.text('LoginSubtext', category: 'login'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Theme(
            data: ThemeData(
              hintColor: Colors.white,
            ),
            child: Column(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child:  TextField(
                      decoration: InputDecoration(
                        hintText: Localization.text('Email', category: 'login'),
                      ),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child:  TextField(
                      decoration: InputDecoration(
                        hintText: Localization.text('Password', category: 'login'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: RaisedButton(
                onPressed: () => _loginButtonPressed(cxt),
                child: Text(Localization.text('Login', category: 'login')),
              ),
            ),
          ),
        ),
        Expanded(flex: 7, child: Container()),
      ],
    );
  }
}