import 'package:bloc/bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("Transition: $transition ");
    if (transition.nextState is Authenticated) {
      print("Hey!  They authenticated!  Let's run a dispatch");
    }
  }
}
