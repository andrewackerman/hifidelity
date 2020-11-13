import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hifidelity/blocs_test/wallets_repository.dart';
import 'package:hifidelity/model/wallet.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class WalletsBloc extends Bloc<WalletsEvent, WalletsState> {
  double _curTotal = 0.0;
  final WalletsRepository _walletsRepository;
  WalletsBloc({@required WalletsRepository walletsRepository})
      : assert(walletsRepository != null),
        _walletsRepository = walletsRepository;

  @override
  WalletsState get initialState => WalletsLoading();

  @override
  Stream<WalletsState> mapEventToState(
    WalletsEvent event,
  ) async* {
    if (event is LoadWallets) {
      yield* _mapLoadWalletsToState();
    } else if (event is AddWallet) {
      yield* _mapAddWalletToState(event);
    } else if (event is UpdateWallet) {
      yield* _mapUpdateWalletToState(event);
    } else if (event is DeleteWallet) {
      yield* _mapDeleteWalletToState(event);
    } else if (event is CheckWallet) {
      yield* _mapCheckWalletToState(event);
    } else if (event is CheckAllWallets) {
      yield* _mapCheckAllWalletsToState();
    }
  }

  Stream<WalletsState> _mapLoadWalletsToState() async* {
    try {
      // Load the wallets from firebase
      List<Wallet> wallets = await _walletsRepository.loadWallets();
      yield WalletsLoaded(wallets);
    } catch (_) {
      yield WalletsNotLoaded();
    }
  }

  Stream<WalletsState> _mapAddWalletToState(AddWallet event) async* {
    // Add wallet to list, then save it
    if (currentState is WalletsLoaded) {
      final List<Wallet> updatedWallets =
          List.from((currentState as WalletsLoaded).wallets ?? [])
            ..add(event.wallet);
      yield WalletsLoaded(updatedWallets);
      _saveWallets(updatedWallets);
    }
  }

  Stream<WalletsState> _mapUpdateWalletToState(UpdateWallet event) async* {
    // Update wallet, then save it
    if (currentState is WalletsLoaded) {
      final List<Wallet> updatedWallets =
          (currentState as WalletsLoaded).wallets.map((wallet) {
        return wallet.address == event.updatedWallet.address
            ? event.updatedWallet
            : wallet;
      }).toList();
      yield WalletsLoaded(updatedWallets);
      _saveWallets(updatedWallets);
    }
  }

  Stream<WalletsState> _mapDeleteWalletToState(DeleteWallet event) async* {
    // Delete wallet, then save
    if (currentState is WalletsLoaded) {
      final List<Wallet> updatedWallets = (currentState as WalletsLoaded)
          .wallets
          .where((wallet) => wallet.address != event.wallet.address)
          .toList();
      yield WalletsLoaded(updatedWallets);
      _saveWallets(updatedWallets);
    }
  }

  Stream<WalletsState> _mapCheckWalletToState(CheckWallet event) async* {
    // Check specified wallet, then save it
    Wallet newWallet = await _walletsRepository.checkWallet(event.wallet);
    // Update wallet, then save it
    if (currentState is WalletsLoaded) {
      final List<Wallet> updatedWallets =
          (currentState as WalletsLoaded).wallets.map((wallet) {
        return wallet.address == newWallet.address ? newWallet : wallet;
      }).toList();
      yield WalletsLoaded(updatedWallets);
      // _saveWallets(updatedWallets);
    }
    return;
  }

  Stream<WalletsState> _mapCheckAllWalletsToState() async* {
    if (currentState is WalletsLoaded) {
      List<Future<Wallet>> allWalletsCheck = new List<Future<Wallet>>();
      _curTotal = 0.0;
      (currentState as WalletsLoaded).wallets.forEach((wallet) {
        allWalletsCheck.add(_walletsRepository.checkWallet(wallet));
      });
      List<Wallet> checkedWallets = await Future.wait(allWalletsCheck);
      yield WalletsLoaded(checkedWallets);
    }
  }

  Future<void> _saveWallets(List<Wallet> wallets) async {
    // We save the wallets here
    await _walletsRepository.saveWallets(wallets);
    return;
  }
}
