import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/user_repository.dart';
import 'package:hifidelity/blocs_test/wallets_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/components/navigation_drawer.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsScreen extends StatefulWidget {
  final UserRepository _userRepository;

  SettingsScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _newWalletController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  WalletsBloc _walletsBloc;

  @override
  void initState() {
    super.initState();
    _walletsBloc = BlocProvider.of<WalletsBloc>(context);
  }

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  final divider = Divider(height: 1, color: Colors.black);

  void showRemoveWalletAddressDialog(BuildContext cxt, String walletAddr) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(AppInheritedWidget.of(cxt)
                .text('WalletDeleteAreYouSure', category: 'settings')),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(cxt).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('NoUpper')),
              ),
              FlatButton(
                onPressed: () {
                  _walletsBloc.dispatch(DeleteWallet(Wallet(walletAddr)));
                  Navigator.of(cxt).pop();
                },
                child: Text(AppInheritedWidget.of(cxt).text('YesUpper')),
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
                onPressed: () => Navigator.of(cxt).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('CancelUpper')),
              ),
              FlatButton(
                onPressed: () {
                  _walletsBloc
                      .dispatch(AddWallet(Wallet(_newWalletController.text)));
                  _walletsBloc
                      .dispatch(CheckWallet(Wallet(_newWalletController.text)));
                  _newWalletController.clear();
                  Navigator.of(cxt).pop();
                },
                child: Text(AppInheritedWidget.of(cxt)
                    .text('Add', category: 'settings')),
              ),
            ],
          );
        });
  }

  void showManagePersonalInfoDialog(BuildContext cxt) {
    final nameController = TextEditingController(text: 'Tanya Michaelson');
    final addressController = TextEditingController(text: '137 Normany Way Rd');
    final cityController = TextEditingController(text: 'Harrisburg, PA, 17109');
    final emailController =
        TextEditingController(text: 'testlongemail@email.com');
    final phoneController = TextEditingController(text: '1-646-555-1234');
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: AppInheritedWidget.of(cxt)
                        .text('Name', category: 'settings'),
                  ),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: AppInheritedWidget.of(cxt)
                        .text('Address', category: 'settings'),
                  ),
                ),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    hintText: AppInheritedWidget.of(cxt)
                        .text('CityStateZip', category: 'settings'),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: AppInheritedWidget.of(cxt)
                        .text('Email', category: 'settings'),
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: AppInheritedWidget.of(cxt)
                        .text('PhoneNumber', category: 'settings'),
                  ),
                ),
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(cxt).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('CancelUpper')),
              ),
              FlatButton(
                onPressed: () => Navigator.of(cxt).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('SaveUpper')),
              ),
            ],
          );
        });
  }

  void showChangePasswordDialog(BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(AppInheritedWidget.of(cxt)
                .text('ChangePassword', category: 'settings')),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(cxt).pop(),
                child: Text(AppInheritedWidget.of(cxt).text('NoUpper')),
              ),
              FlatButton(
                onPressed: () async {
                  try {
                    await widget._userRepository.resetPassword();
                    _emailController.clear();
                    Scaffold.of(cxt)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email sent to linked account"),
                              Icon(Icons.email),
                            ],
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      );
                  } catch (_) {
                    Scaffold.of(cxt)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Password Reset Failed to send'),
                              Icon(Icons.error),
                            ],
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                  } finally {
                    Navigator.of(cxt).pop();
                  }
                },
                child: Text(AppInheritedWidget.of(cxt).text('YesUpper')),
              ),
            ],
          );
        });
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

  IconData getIcon(wallet) {
    if (wallet.state == WalletState.Valid) {
      return MdiIcons.checkCircleOutline;
    } else if (wallet.state == WalletState.Invalid) {
      return MdiIcons.cancel;
    } else if (wallet.state == WalletState.Empty) {
      return MdiIcons.clipboardAlertOutline;
    } else {
      return MdiIcons.cloudQuestion;
    }
  }

  MaterialColor getColor(wallet) {
    if (wallet.state == WalletState.Valid) {
      return Colors.green;
    } else if (wallet.state == WalletState.Invalid) {
      return Colors.red;
    } else if (wallet.state == WalletState.Empty) {
      return Colors.orange;
    } else {
      return Colors.grey;
    }
  }

  List<Widget> buildWalletList(BuildContext cxt, List<Wallet> wallets) {
    List<Widget> widWallets = [];

    print("Wallets: $wallets");

    for (Wallet wallet in wallets) {
      widWallets.add(
        Material(
          child: InkWell(
            onLongPress: () =>
                showRemoveWalletAddressDialog(cxt, wallet.address),
            child: padListItem(
              child: Container(
                child: Row(
                  children: [
                    Text(
                      wallet.address,
                      style: TextStyle(fontSize: 12),
                    ),
                    Expanded(child: Container()),
                    Icon(
                      getIcon(wallet),
                      color: getColor(wallet),
                    ),
                  ],
                ),
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

  List<Widget> buildPersonalInfo(BuildContext cxt) {
    return [
      padListItem(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanya Michaelson'),
            Text('137 Normany Way Rd'),
            Text('Harrisburg, PA, 17109'),
            Text('testlongemail@email.com'),
            Text('1-646-555-1234'),
          ],
        ),
      ),
      divider,
      buildListViewActionRow(
        text: AppInheritedWidget.of(cxt).text('Manage', category: 'settings'),
        callback: () => showManagePersonalInfoDialog(cxt),
      ),
    ];
  }

  List<Widget> buildLanguageSetting(BuildContext cxt) {
    final language = AppInheritedWidget.of(cxt).language;
    return [
      buildListViewActionRow(
        text: language.name,
        callback: () => _drawerLanguageButtonClicked(cxt),
      ),
    ];
  }

  List<Widget> buildChangePassword(BuildContext cxt) {
    return [
      buildListViewActionRow(
        text: AppInheritedWidget.of(cxt)
            .text('ChangePassword', category: 'settings'),
        callback: () => showChangePasswordDialog(cxt),
      ),
    ];
  }

  Widget buildSettingsSectionHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget buildSettingsFloatingSection({Widget child}) {
    return FractionallySizedBox(
      widthFactor: 0.93,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 57, 153, 184),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Center(child: Image.asset('assets/images/7tk_title.png')),
        ),
        actions: [
          InkWell(
            onTap: () => _drawerLanguageButtonClicked(cxt),
            child: Row(
              children: [
                Text(AppInheritedWidget.of(cxt).language.displayCode),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 12),
                  child: Icon(MdiIcons.earth, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            buildSettingsSectionHeader(AppInheritedWidget.of(cxt)
                .text('Wallets', category: 'settings')),
            buildSettingsFloatingSection(
              child: BlocBuilder(
                  bloc: _walletsBloc,
                  builder: (BuildContext context, WalletsState state) {
                    List<Wallet> wallets = [];
                    print("State: $state");
                    if (state is WalletsLoaded) {
                      wallets = state.wallets;
                      _walletsBloc.dispatch(CheckAllWallets());
                    }
                    return Column(
                      children: buildWalletList(cxt, wallets),
                    );
                  }),
            ),
            // buildSettingsSectionHeader(AppInheritedWidget.of(cxt)
            //     .text('PersonalInfo', category: 'settings')),
            // buildSettingsFloatingSection(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: buildPersonalInfo(cxt),
            //   ),
            // ),
            buildSettingsSectionHeader(AppInheritedWidget.of(cxt)
                .text('Language', category: 'settings')),
            buildSettingsFloatingSection(
              child: Column(
                children: buildLanguageSetting(cxt),
              ),
            ),
            buildSettingsSectionHeader(AppInheritedWidget.of(cxt)
                .text('Password', category: 'settings')),
            buildSettingsFloatingSection(
              child: Column(
                children: buildChangePassword(cxt),
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
      endDrawer: LocalizationDrawer(),
    );
  }

  @override
  void dispose() {
    _newWalletController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
