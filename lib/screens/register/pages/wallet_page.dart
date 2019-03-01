import 'package:flutter/material.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  State createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  List<Wallet> wallets = [
    Wallet('1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2', WalletState.Valid),
    Wallet('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy', WalletState.Empty),
    Wallet('bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq', WalletState.Invalid),
  ];

  void continueButtonPressed() {
    Navigator.of(context).pushNamed('register/success');
  }

  Icon getWalletIcon(Wallet wallet) {
    switch (wallet.state) {
      case WalletState.Valid:
        return Icon(MdiIcons.checkCircleOutline, color: Colors.green);
      case WalletState.Empty:
        return Icon(MdiIcons.clockOutline, color: Colors.yellow);
      case WalletState.Invalid:
        return Icon(MdiIcons.cancel, color: Colors.red);
    }

    return null;
  }

  List<Widget> buildWalletRows(BuildContext cxt) {
    var rows = <Widget>[];

    final divider = Divider(color: Colors.white, height: 1);

    for (var wallet in wallets) {
      rows.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                wallet.address,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            FittedBox(
              child: getWalletIcon(wallet),
            ),
          ],
        ),
      ));
      rows.add(divider);
    }

    return rows;
  }

  @override
  Widget build(BuildContext cxt) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container()),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'Wallet addresses',
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
              'Please enter the wallet address from your 7tk token purchase(s).',
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
            child: SingleChildScrollView(
              child: Column(
                children: buildWalletRows(cxt)
              ),
            ),
          ),
        ),
        Expanded(child: Container()),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: RaisedButton(
              onPressed: continueButtonPressed,
              child: Text('ADD NEW ADDRESS'),
            ),
          ),
        ),
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
}

class Wallet {
  final String address;
  final WalletState state;

  Wallet(this.address, this.state);
}

enum WalletState {
  Invalid,
  Empty,
  Valid,
}