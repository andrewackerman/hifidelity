import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/screens/register/register_screen.dart';

class SuccessPage extends StatefulWidget {
  final GlobalKey<RegisterScreenState> parentKey;

  SuccessPage(this.parentKey);

  @override
  State createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage> {
  
  void continueButtonPressed() {
    widget.parentKey.currentState.pop();
  }

  @override
  Widget build(BuildContext cxt) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.5,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Image.asset(
              'assets/images/large_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'Success!',
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
              'Thanks for registering your account. We\'ve sent you a confirmation email verifying that your account has been registered.',
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
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: RaisedButton(
              onPressed: continueButtonPressed,
              child: Text('FINISH'),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}