import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/redirect_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/wallets_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:hifidelity/screens/dashboard/dashboard_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  State createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  WalletsBloc _walletsBloc;
  final TextEditingController _newWalletController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _walletsBloc = BlocProvider.of<WalletsBloc>(context);
  }

  // void continueButtonPressed() {
  //   Navigator.of(context).pushNamed('register/success');
  // }

  void showRemoveWalletAddressDialog(BuildContext cxt, String walletAddr) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black38,
            content: Text(
              AppInheritedWidget.of(cxt)
                  .text('WalletDeleteAreYouSure', category: 'settings'),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('NoUpper'),
                    style: TextStyle(color: Colors.white)),
              ),
              FlatButton(
                onPressed: () {
                  _walletsBloc.dispatch(DeleteWallet(Wallet(walletAddr)));
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppInheritedWidget.of(cxt).text('YesUpper'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void showAddWalletAddressDialog(BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black38,
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _newWalletController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: AppInheritedWidget.of(cxt)
                          .text('WalletAddress', category: 'settings'),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('CancelUpper')),
              ),
              FlatButton(
                onPressed: () {
                  _walletsBloc
                      .dispatch(AddWallet(Wallet(_newWalletController.text)));
                  _walletsBloc
                      .dispatch(CheckWallet(Wallet(_newWalletController.text)));
                  _newWalletController.clear();
                  Navigator.of(context).pop();
                },
                child: Text(AppInheritedWidget.of(cxt)
                    .text('Add', category: 'settings')),
              ),
            ],
          );
        });
  }

  Icon getWalletIcon(Wallet wallet) {
    switch (wallet.state) {
      case WalletState.Valid:
        return Icon(MdiIcons.checkCircleOutline, color: Colors.green);
      case WalletState.Empty:
        return Icon(MdiIcons.clipboardAlert, color: Colors.orange);
      case WalletState.Invalid:
        return Icon(MdiIcons.cancel, color: Colors.red);
      case WalletState.Unknown:
        return Icon(MdiIcons.cloudQuestion, color: Colors.grey);
    }

    return null;
  }

  List<Widget> buildWalletRows(BuildContext cxt, List<Wallet> wallets) {
    List<Widget> widWallets = [];

    final divider = Divider(color: Colors.white, height: 1);

    for (Wallet wallet in wallets) {
      widWallets.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            onLongPress: () =>
                showRemoveWalletAddressDialog(cxt, wallet.address),
            child: Padding(
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
            ),
          ),
        ),
      );
      widWallets.add(divider);
    }

    widWallets.add(
      buildListViewActionRow(
        text: AppInheritedWidget.of(cxt).text('Manage', category: 'settings'),
        callback: () => showAddWalletAddressDialog(cxt),
      ),
    );

    return widWallets;
  }

  Widget padListItem({Widget child}) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: child,
    );
  }

  Widget buildListViewActionRow({String text, VoidCallback callback}) {
    var widget = padListItem(
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          Icon(
            MdiIcons.chevronRight,
            color: Colors.grey[800],
          ),
        ],
      ),
    );

    if (callback != null) {
      widget = Material(
        child: InkWell(
          onTap: callback,
          child: widget,
        ),
      );
    }

    return widget;
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
              child: BlocBuilder(
                  bloc: _walletsBloc,
                  builder: (BuildContext context, WalletsState state) {
                    if (state is WalletsLoaded) {
                      return Column(
                          children: buildWalletRows(context, state.wallets));
                    } else {
                      return Column(children: buildWalletRows(context, []));
                    }
                  }),
            ),
          ),
        ),
        Expanded(child: Container()),
        // Center(
        //   child: FractionallySizedBox(
        //     widthFactor: 0.6,
        //     child: buildListViewActionRow(
        //       text: ('ADD NEW ADDRESS'),
        //       callback: () => showAddWalletAddressDialog(cxt),
        //     ),
        //   ),
        // ),
        Center(
          child: FractionallySizedBox(
            widthFactor: 0.6,
            child: BlocBuilder(
                bloc: _walletsBloc,
                builder: (BuildContext context, WalletsState state) {
                  return RaisedButton(
                    onPressed: () {
                      // BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
                      // Navigator.of(context).pushNamed('/');
                      BlocProvider.of<RedirectBloc>(context)
                          .dispatch(NavDashboard());
                    },
                    child: Text('CONTINUE'),
                  );
                }),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  @override
  void dispose() {
    _newWalletController.dispose();
    super.dispose();
  }
}
