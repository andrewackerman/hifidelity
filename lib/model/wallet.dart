import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

enum WalletState { Unknown, Invalid, Valid, Empty }

@immutable
class Wallet extends Equatable {
  final String address;
  final WalletState state;
  final double amount;

  Wallet(this.address, {this.state = WalletState.Unknown, this.amount = 0.0})
      : super([address, state, amount]);

  Wallet copyWith({String address, WalletState state}) {
    return Wallet(address ?? this.address,
        state: state ?? this.state, amount: amount ?? this.amount);
  }

  @override
  String toString() {
    return 'Wallet { Address: $address, State: $state, Amount: $amount }';
  }
}
