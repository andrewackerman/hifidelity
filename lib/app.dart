import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart' as prefix0;
import 'package:hifidelity/blocs_test/stats_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/user_repository.dart';
import 'package:hifidelity/blocs_test/wallets_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/wallets_repository.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/screens/dashboard/dashboard_screen.dart';
import 'package:hifidelity/screens/landing/landing_screen.dart';
import 'package:hifidelity/screens/register/pages/password_page.dart';
import 'package:hifidelity/screens/register/pages/splash_screen.dart';
import 'package:hifidelity/screens/register/pages/start_page.dart';
import 'package:hifidelity/screens/register/pages/wallet_page.dart';
import 'package:hifidelity/screens/register/register_screen.dart';
import 'package:hifidelity/screens/settings/settings_screen.dart';
import 'package:hifidelity/services/localization/localization_service.dart';

import 'blocs_test/redirect_bloc/bloc.dart';
import 'blocs_test/register_bloc/bloc.dart';
// import 'package:hifidelity/services/auth/auth_bloc.dart';
// import 'package:hifidelity/services/registration/register_bloc.dart';
// import 'package:hifidelity/services/wallets/wallet_bloc.dart';

class AppScreen extends StatefulWidget {
  @override
  State createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  GlobalKey<RegisterScreenState> registerScreenKey = GlobalKey();
  final navigatorKey = new GlobalKey<NavigatorState>();
  final localizationService = LocalizationService();
  final UserRepository _userRepository = UserRepository();
  WalletsRepository _walletsRepository;
  AuthenticationBloc _authenticationBloc;
  RegisterBloc _registerBloc;
  WalletsBloc _walletsBloc;
  StatsBloc _statsBloc;
  RedirectBloc _redirectBloc;
  // var authenticationBloc;
  // var registrationBloc;
  // var walletBloc;

  @override
  void initState() {
    localizationService.languageCode = 'en-US';
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // authenticationBloc = AuthenticationBloc(localizationService);
    // registrationBloc = RegistrationBloc(localizationService);
    // walletBloc = WalletBloc(localizationService, authenticationBloc);
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _registerBloc = RegisterBloc(userRepository: _userRepository);
    _walletsRepository = WalletsRepository(userRepository: _userRepository);
    _walletsBloc = WalletsBloc(walletsRepository: _walletsRepository);
    _statsBloc = StatsBloc(walletsBloc: _walletsBloc);
    _redirectBloc = RedirectBloc();
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onInheritedWidgetValueChanged() {
    setState(() {});
  }

  Widget scaffold(Widget child) {
    return AppInheritedWidget(
      localization: localizationService,
      valueChanged: onInheritedWidgetValueChanged,
      // authBloc: authenticationBloc,
      // regBloc: registrationBloc,
      // walletBloc: walletBloc,
      child: child,
    );
  }

  @override
  Widget build(BuildContext cxt) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc),
          BlocProvider<RegisterBloc>(bloc: _registerBloc),
          BlocProvider<WalletsBloc>(bloc: _walletsBloc),
          BlocProvider<StatsBloc>(bloc: _statsBloc),
          BlocProvider<RedirectBloc>(bloc: _redirectBloc),
        ],
        child: BlocListenerTree(
          blocListeners: [
            BlocListener<AuthenticationEvent, AuthenticationState>(
              bloc: _authenticationBloc,
              listener: (BuildContext context, AuthenticationState state) {
                print("Hey we got a listener trigger!");
                print("State: { $state }");
                if (state is Authenticated) {
                  _redirectBloc.dispatch(NavDashboard(isAuthenticated: true));
                  _walletsBloc.dispatch(LoadWallets());
                  _walletsBloc.dispatch(CheckAllWallets());
                } else if (state is Unauthenticated) {
                  _redirectBloc.dispatch(NavLogin());
                } else if (state is LoggedOut) {
                  _redirectBloc.dispatch(NavLogin());
                }
              },
            ),
          ],
          child: scaffold(
            MaterialApp(
              home: BlocBuilder(
                bloc: _redirectBloc,
                builder: (BuildContext context, RedirectState state) {
                  if (state is UninitializedState) {
                    return (SplashScreen());
                  } else if (state is LoginPageState) {
                    return (LandingScreen(
                      userRepository: _userRepository,
                    ));
                  } else if (state is RegisterPage1State) {
                    return (RegisterScreen(
                        usedScreen: StartPage(),
                        userRepository: _userRepository));
                  } else if (state is RegisterPage2State) {
                    return (RegisterScreen(
                        usedScreen: PasswordPage(
                          email: state.email,
                        ),
                        userRepository: _userRepository));
                  } else if (state is RegisterPage3State) {
                    return (RegisterScreen(
                        usedScreen: WalletPage(),
                        userRepository: _userRepository));
                  } else if (state is DashboardPageState) {
                    return (DashboardScreen());
                  } else if (state is SettingsPageState) {
                    return (SettingsScreen(
                      userRepository: _userRepository,
                    ));
                  }
                },
              ),
              // home: BlocBuilder(
              //   bloc: _authenticationBloc,
              //   builder: (BuildContext context, AuthenticationState state) {
              //     if (state is Uninitialized) {
              //       return (SplashScreen());
              //     } else if (state is Authenticated) {
              //       _walletsBloc.dispatch(LoadWallets());
              //       _walletsBloc.dispatch(CheckAllWallets());
              //       return (DashboardScreen());
              //     } else {
              //       return (LandingScreen(
              //         userRepository: _userRepository,
              //       ));
              //     }
              //   },
              // ),
              debugShowCheckedModeBanner: false,
              // routes: {
              //   // '/': (cxt) => scaffold(LandingScreen()),
              //   'register': (cxt) => (RegisterScreen(key: registerScreenKey)),
              //   'dashboard': (cxt) => (DashboardScreen()),
              //   'settings': (cxt) => (SettingsScreen()),
              // },
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
