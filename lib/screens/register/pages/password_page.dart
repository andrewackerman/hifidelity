import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PasswordPage extends StatefulWidget {
  @override
  State createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  bool showPassword = false;

  void continueButtonPressed() {
    Navigator.of(context).pushNamed('register/wallet');
  }

  Widget buildPasswordSection(BuildContext cxt) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'Create a password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Please enter a password below. It must be between 8 and 24 characters and contain at least one number and symbol.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                TextField(
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      showPassword ? MdiIcons.eyeOff : MdiIcons.eye, 
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Container()),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: RaisedButton(
              onPressed: continueButtonPressed,
              child: Text('CONTINUE'),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return Column(
      children: [
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
          child: buildPasswordSection(cxt),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}