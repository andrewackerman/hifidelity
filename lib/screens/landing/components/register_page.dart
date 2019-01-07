import 'package:flutter/material.dart';
import 'package:hifidelity/services/localization/localization.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  Localization.text('RegisterText', category: 'register'),
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
                  Localization.text('RegisterSubtext', category: 'register'),
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
                        hintText: Localization.text('Name', category: 'register'),
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
                onPressed: () {},
                child: Text(Localization.text('Register', category: 'register')),
              ),
            ),
          ),
        ),
        Expanded(flex: 7, child: Container()),
      ],
    );
  }
}