import 'package:flutter/material.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/components/navigation_drawer.dart';
import 'package:hifidelity/services/localization/localization.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final walletAddresses = [
    WalletAddress(
      address: '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2',
      isValid: true,
    ),
    WalletAddress(
      address: '3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy',
      isValid: true,
    ),
    WalletAddress(
      address: 'bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq',
      isValid: false,
    ),
  ];

  @override
  void initState() {
    Localization.addListener(localeChanged);
    super.initState();
  }

  @override
  void dispose() {
    Localization.removeListener(localeChanged);
    super.dispose();
  }

  void localeChanged(Locale newLocale) {
    setState(() {});
  }

  void _drawerLanguageButtonClicked(BuildContext cxt) {
    _scaffoldKey.currentState.openEndDrawer();
  }

  final divider = Divider(height: 1, color: Colors.black);

  void showRemoveWalletAddressDialog(BuildContext cxt) {
    showDialog(context: cxt, builder: (BuildContext context) {
      return AlertDialog(
        content: Text(Localization.text('WalletDeleteAreYouSure', category: 'settings')),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('NoUpper')),
          ),
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('YesUpper')),
          ),
        ],
      );
    });
  }

  void showAddWalletAddressDialog(BuildContext cxt) {
    showDialog(context: cxt, builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: Localization.text('WalletAddress', category: 'settings'),
              ),
            ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('CancelUpper')),
          ),
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('Add', category: 'settings')),
          ),
        ],
      );
    });
  }

  void showManagePersonalInfoDialog(BuildContext cxt) {
    final nameController = TextEditingController(text: 'Tanya Michaelson');
    final addressController = TextEditingController(text: '137 Normany Way Rd');
    final cityController = TextEditingController(text: 'Harrisburg, PA, 17109');
    final emailController = TextEditingController(text: 'testlongemail@email.com');
    final phoneController = TextEditingController(text: '1-646-555-1234');
    showDialog(context: cxt, builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: Localization.text('Name', category: 'settings'),
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: Localization.text('Address', category: 'settings'),
              ),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: Localization.text('CityStateZip', category: 'settings'),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: Localization.text('Email', category: 'settings'),
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: Localization.text('PhoneNumber', category: 'settings'),
              ),
            ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('CancelUpper')),
          ),
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('SaveUpper')),
          ),
        ],
      );
    });
  }

  void showChangePasswordDialog(BuildContext cxt) {
    showDialog(context: cxt, builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 2),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: Localization.text('Password', category: 'settings'),
              ),
            ),
          ],
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('CancelUpper')),
          ),
          FlatButton(
            onPressed: () => Navigator.of(cxt).pop(),
            child: Text(Localization.text('SaveUpper')),
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

  Widget buildListViewRow({ String text, VoidCallback callback }) {
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

  List<Widget> buildWalletList(BuildContext cxt) {
    List<Widget> wallets = [];

    for (var address in walletAddresses) {
      wallets.add(
        Material(
          child: InkWell(
            onLongPress: () => showRemoveWalletAddressDialog(cxt),
            child: padListItem(
              child: Row(
                children: [
                  Text(
                    address.address,
                  ),
                  Expanded(child: Container()),
                  Icon(
                    address.isValid ? MdiIcons.checkCircleOutline : MdiIcons.cancel,
                    color: address.isValid ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      wallets.add(divider);
    }

    wallets.add(
      buildListViewRow(
        text: Localization.text('Manage', category: 'settings'),
        callback: () => showAddWalletAddressDialog(cxt),
      ),
    );

    return wallets;
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
      buildListViewRow(
        text: Localization.text('Manage', category: 'settings'),
        callback: () => showManagePersonalInfoDialog(cxt),
      ),
    ];
  }

  List<Widget> buildLanguageSetting(BuildContext cxt) {
    final language = Localization.getCurrentLanguage();
    return [
      buildListViewRow(
        text: language.name,
        callback: () => _drawerLanguageButtonClicked(cxt),
      ),
    ];
  }

  List<Widget> buildChangePassword(BuildContext cxt) {
    return [
      buildListViewRow(
        text: Localization.text('ChangePassword', category: 'settings'),
        callback: () => showChangePasswordDialog(cxt),
      ),
    ];
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
                Text(Localization.getCurrentLanguage().displayCode),
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
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 6),
              child: Text(
                Localization.text('Wallets', category: 'settings'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.93,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Column(
                  children: buildWalletList(cxt),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 6),
              child: Text(
                Localization.text('PersonalInfo', category: 'settings'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.93,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildPersonalInfo(cxt),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 6),
              child: Text(
                Localization.text('Language', category: 'settings'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.93,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Column(
                  children: buildLanguageSetting(cxt),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 6),
              child: Text(
                Localization.text('Password', category: 'settings'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.93,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Column(
                  children: buildChangePassword(cxt),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(),
      endDrawer: LocalizationDrawer(),
    );
  }
}

class WalletAddress {
  final String address;
  final bool isValid;

  WalletAddress({
    this.address,
    this.isValid,
  });
}