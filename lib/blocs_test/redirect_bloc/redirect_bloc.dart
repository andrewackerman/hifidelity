import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class RedirectBloc extends Bloc<RedirectEvent, RedirectState> {
  @override
  RedirectState get initialState => UninitializedState();

  @override
  Stream<RedirectState> mapEventToState(
    RedirectEvent event,
  ) async* {
    if (event is NavLogin) {
      yield LoginPageState();
    } else if (event is NavRegister1) {
      yield RegisterPage1State();
    } else if (event is NavRegister2) {
      yield RegisterPage2State(email: event.email);
    } else if (event is NavRegister3) {
      yield RegisterPage3State();
    } else if (event is NavDashboard) {
      print("In nav dashboard: $currentState");
      if (event.isAuthenticated && currentState is LoginPageState) {
        yield DashboardPageState();
      } else if (event.isAuthenticated && currentState is! UninitializedState) {
        yield currentState;
      } else if (event.isAuthenticated && currentState is RegisterPage3State) {
        yield currentState;
      } else {
        yield DashboardPageState();
      }
    } else if (event is NavSettings) {
      yield SettingsPageState();
    }
  }
}
