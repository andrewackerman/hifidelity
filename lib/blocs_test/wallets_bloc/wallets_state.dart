import 'package:equatable/equatable.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WalletsState extends Equatable {
  WalletsState([List props = const []]) : super(props);
}

class WalletsLoading extends WalletsState {
  @override
  String toString() => 'WalletsLoading';
}

class WalletsLoaded extends WalletsState {
  final List<Wallet> wallets;

  WalletsLoaded([this.wallets = const []]) : super([wallets]);

  @override
  String toString() => 'WalletsLoaded { wallets: $wallets }';
}

class WalletsNotLoaded extends WalletsState {
  @override
  String toString() => 'WalletsNotLoaded';
}
