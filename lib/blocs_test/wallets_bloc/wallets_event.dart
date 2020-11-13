import 'package:equatable/equatable.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WalletsEvent extends Equatable {
  WalletsEvent([List props = const []]) : super(props);
}

class LoadWallets extends WalletsEvent {
  @override
  String toString() => 'LoadWallets';
}

class AddWallet extends WalletsEvent {
  final Wallet wallet;

  AddWallet(this.wallet) : super([wallet]);

  @override
  String toString() => 'AddWallet { wallet: $wallet }';
}

class UpdateWallet extends WalletsEvent {
  final Wallet updatedWallet;

  UpdateWallet(this.updatedWallet) : super([updatedWallet]);

  @override
  String toString() => 'UpdateWallet { updatedWallet: $updatedWallet }';
}

class DeleteWallet extends WalletsEvent {
  final Wallet wallet;

  DeleteWallet(this.wallet) : super([wallet]);

  @override
  String toString() => 'DeleteWallet { wallet: $wallet }';
}

class CheckWallet extends WalletsEvent {
  final Wallet wallet;

  CheckWallet(this.wallet) : super([wallet]);

  @override
  String toString() => 'CheckWallet { wallet: $wallet }';
}

class CheckAllWallets extends WalletsEvent {
  @override
  String toString() => 'CheckAllWallets';
}
