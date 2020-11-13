import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RedirectState extends Equatable {
  RedirectState([List props = const []]) : super(props);
}

class UninitializedState extends RedirectState {
  @override
  String toString() => 'Uninitialized';
}

class LoginPageState extends RedirectState {
  @override
  String toString() => 'LoginPage';
}

class RegisterPage0State extends RedirectState {
  @override
  String toString() => 'RegisterPage0';
}

class RegisterPage1State extends RedirectState {
  @override
  String toString() => 'RegisterPage1';
}

class RegisterPage2State extends RedirectState {
  final String email;
  RegisterPage2State({@required this.email}) : super([email]);
  @override
  String toString() => 'RegisterPage2 { Email: $email }';
}

class RegisterPage3State extends RedirectState {
  @override
  String toString() => 'RegisterPage3';
}

class DashboardPageState extends RedirectState {
  @override
  String toString() => 'DashboardPage';
}

class SettingsPageState extends RedirectState {
  @override
  String toString() => 'SettingsPage';
}
