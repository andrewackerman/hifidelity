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
              Localization.text('LoginText', category: 'login'),
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
              Localization.text('LoginSubtext', category: 'login'),
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
                  hintText: Localization.text('Email', category: 'login'),
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
                  hintText: Localization.text('Password', category: 'login'),
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
                onPressed: () => _loginButtonPressed(cxt),
                child: Text(Localization.text('Login', category: 'login')),
              ),
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }
}