import 'package:flutter/material.dart';
import 'package:hifidelity/services/localization/localization.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void showRegisterDialog(BuildContext cxt) {
    showDialog(context: cxt, builder: (context) {
      return new AlertDialog(
        content: Text(Localization.text('RegistrationNotAvailable', category: 'register')),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(Localization.text('OK')),
          )
        ],
      );
    });
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
              Localization.text('RegisterText', category: 'register'),
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
              Localization.text('RegisterSubtext', category: 'register'),
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
                  hintText: Localization.text('Name', category: 'register'),
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
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
                  hintText: Localization.text('Email', category: 'register'),
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: RaisedButton(
                onPressed: () => showRegisterDialog(cxt),
                child: Text(Localization.text('Register', category: 'register')),
              ),
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }
}