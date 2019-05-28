import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hifidelity/blocs_test/user_repository.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:meta/meta.dart';

class WalletsRepository {
  UserRepository _userRepository;
  final String tokenAddr = "0xad018F6Cb9a721cBd9739A3Cb3b610d46bDC922b";
  final String walletChecker = "https://api.tokenbalance.com/token";

  WalletsRepository({@required UserRepository userRepository}) {
    this._userRepository = userRepository;
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  }

  Future<List<Wallet>> loadWallets() async {
    FirebaseUser user = await _userRepository.getUser();

    List<Wallet> wallets = [];

    if (user == null) {
      return wallets;
    }
    try {
      print("User uid: ${user.uid}");
      DocumentSnapshot snap = await Firestore.instance
          .collection('/users')
          .document(user.uid)
          .get();
      print(snap.data["wallets"]);
      snap.data["wallets"].forEach((address) {
        wallets.add(Wallet(address.trim()));
      });
      print(wallets);
    } catch (_) {}

    return wallets;
  }

  Future<void> saveWallets(List<Wallet> wallets) async {
    List<String> walletAddresses = [];
    wallets.forEach((wallet) {
      walletAddresses.add(wallet.address);
    });
    FirebaseUser curUser = await _userRepository.getUser();
    DocumentReference userRef =
        Firestore.instance.collection('/users').document(curUser.uid);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnap = await tx.get(userRef);
      // If it doesn't exist, create it
      if (!userSnap.exists) {
        print("User Documents did not exist, creating one");
        userRef.setData({
          'wallets': [""]
        });
        // await tx.set(userRef, {
        //   'wallets': [""]
        // });
      }
      await tx.update(userRef, {'wallets': walletAddresses});
    });
  }

  Future<Wallet> checkWallet(Wallet wallet) async {
    print("Checking ${wallet.address}");
    try {
      String url = "$walletChecker/$tokenAddr/${wallet.address}";
      // print("URL: $url");
      // final uri = Uri(path: url);
      // print("URI: $uri");
      var response = await http.read(url);
      Map<String, dynamic> respJson = json.decode(response);
      print(
          "RESP: {wallet: ${respJson["wallet"]}, balance: ${respJson["balance"]}}");
      if (respJson["balance"] != null &&
          respJson["wallet"] != "0x0000000000000000000000000000000000000000") {
        double foundAmount = double.parse(respJson["balance"]);
        if (foundAmount != 0) {
          return Wallet(wallet.address,
              state: WalletState.Valid, amount: foundAmount);
        } else {
          return Wallet(wallet.address,
              state: WalletState.Empty, amount: foundAmount);
        }
      } else {
        return Wallet(wallet.address, state: WalletState.Invalid);
      }
    } catch (_) {
      return Wallet(wallet.address, state: WalletState.Invalid);
    }
  }
}
