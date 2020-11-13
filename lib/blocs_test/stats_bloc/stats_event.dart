import 'package:equatable/equatable.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsEvent extends Equatable {
  StatsEvent([List props = const []]) : super(props);
}

class UpdateStats extends StatsEvent {
  final List<Wallet> wallets;
  UpdateStats(this.wallets) : super([wallets]);

  @override
  String toString() => 'UpdateStats { wallets: $wallets }';
}
