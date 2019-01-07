import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  'Login to your account',
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
                  'Please fill out the info below.',
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
                        hintText: 'Email',
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
                        hintText: 'Password',
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
                onPressed: () => Navigator.of(cxt).pushNamed('/home'),
                child: Text('LOGIN'),
              ),
            ),
          ),
        ),
        Expanded(flex: 7, child: Container()),
      ],
    );
  }
}