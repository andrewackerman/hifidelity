import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hifidelity/blocs_test/wallets_bloc/bloc.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final WalletsBloc walletsBloc;
  StreamSubscription walletsSubscription;

  StatsBloc({@required this.walletsBloc}) {
    walletsSubscription = walletsBloc.state.listen((state) {
      if (state is WalletsLoaded) {
        dispatch(UpdateStats(state.wallets));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int totalTokens = 0;
      event.wallets.forEach((wallet) {
        totalTokens += wallet.amount.toInt();
      });
      yield StatsLoaded(totalTokens);
    }
  }

  @override
  void dispose() {
    walletsSubscription.cancel();
    super.dispose();
  }
}
