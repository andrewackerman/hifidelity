import 'package:flutter/material.dart';

class IPhoneXScaffold extends StatelessWidget {
  final Key key;
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final bool resizeToAvoidBottomPadding;
  final bool primary;

  IPhoneXScaffold({
    this.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomPadding = true,
    this.primary = true,
  });

  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: this.key,
      appBar: this.appBar,
      body: this.body,
      floatingActionButton: this.floatingActionButton,
      floatingActionButtonLocation: this.floatingActionButtonLocation,
      floatingActionButtonAnimator: this.floatingActionButtonAnimator,
      persistentFooterButtons: this.persistentFooterButtons,
      drawer: this.drawer,
      endDrawer: this.endDrawer,
      bottomNavigationBar: this.bottomNavigationBar,
      bottomSheet: this.bottomSheet,
      backgroundColor: this.backgroundColor,
      resizeToAvoidBottomPadding: this.resizeToAvoidBottomPadding,
      primary: this.primary,
    );
  }
}