import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RedirectEvent extends Equatable {
  RedirectEvent([List props = const []]) : super(props);
}

class NavLogin extends RedirectEvent {
  @override
  String toString() => 'NavLogin';
}

class NavRegister1 extends RedirectEvent {
  @override
  String toString() => 'NavRegister1';
}

class NavRegister2 extends RedirectEvent {
  final String email;

  NavRegister2({@required this.email}) : super([email]);
  @override
  String toString() => 'NavRegister2 { email: $email }';
}

class NavRegister3 extends RedirectEvent {
  @override
  String toString() => 'NavRegister3';
}

class NavDashboard extends RedirectEvent {
  final bool isAuthenticated;
  NavDashboard({this.isAuthenticated = false}) : super([isAuthenticated]);

  @override
  String toString() => 'NavDashboard : {$isAuthenticated}';
}

class NavSettings extends RedirectEvent {
  @override
  String toString() => 'NavSettings';
}
