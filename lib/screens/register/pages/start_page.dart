import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';

class StartPage extends StatefulWidget {
  @override
  State createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  String name;
  String email;

  void continueButtonPressed() {
    Navigator.of(context).pushNamed('register/info');
  }

  Widget buildRegisterSection(BuildContext cxt) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            AppInheritedWidget.of(cxt).text('RegisterText', category: 'register'),
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
            AppInheritedWidget.of(cxt).text('RegisterSubtext', category: 'register'),
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
                hintText: AppInheritedWidget.of(cxt).text('Name', category: 'register'),
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
                hintText: AppInheritedWidget.of(cxt).text('Email', category: 'register'),
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
          child: buildRegisterSection(cxt),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}