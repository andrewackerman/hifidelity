import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/redirect_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/components/localization_drawer.dart';
import 'package:hifidelity/screens/register/register_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hifidelity/blocs_test/login_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/user_repository.dart';

class LandingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  static const routeName = "/home";

  LandingScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  State createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      userRepository: _userRepository,
    );
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void drawerLanguageButtonPressed() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void registerButtonPressed() {
    BlocProvider.of<RedirectBloc>(context).dispatch(NavRegister1());
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return RegisterScreen(
    //     userRepository: _userRepository,
    //   );
    // }));
  }

  Widget buildLanguageButton(BuildContext cxt) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: drawerLanguageButtonPressed,
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Text(
                    AppInheritedWidget.of(cxt).language.displayCode,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationStyle: TextDecorationStyle.dotted,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 12),
                    child: Icon(MdiIcons.earth, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginSection(BuildContext cxt) {
    return Theme(
        data: ThemeData(
          hintColor: Colors.white,
        ),
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (BuildContext context, LoginState state) {
            return Form(
              child: Column(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      AppInheritedWidget.of(cxt)
                          .text('LoginText', category: 'login'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: Text(
                      AppInheritedWidget.of(cxt)
                          .text('LoginSubtext', category: 'login'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: AppInheritedWidget.of(cxt)
                                .text('Email', category: 'login'),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          autovalidate: true,
                          autocorrect: false,
                          validator: (_) {
                            return !state.isEmailValid ? 'Invalid Email' : null;
                          }),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppInheritedWidget.of(cxt)
                              .text('Password', category: 'login'),
                        ),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isEmailValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: RaisedButton(
                        onPressed: isLoginButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                        child: Text(AppInheritedWidget.of(cxt)
                            .text('Login', category: 'login')),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            );
          },
        ));
  }

  double innerHeight = -1;
  @override
  Widget build(BuildContext cxt) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: LocalizationDrawer(),
      body: BlocListener(
        bloc: _loginBloc,
        listener: (BuildContext context, LoginState state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(builder: (_, constraints) {
              if (innerHeight == -1) innerHeight = constraints.biggest.height;
              return SingleChildScrollView(
                child: SizedBox(
                  width: constraints.biggest.width,
                  height: innerHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildLanguageButton(cxt),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 175,
                              maxHeight: 175,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                'assets/images/large_logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: buildLoginSection(cxt),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                AppInheritedWidget.of(cxt)
                                    .text('DontHaveLogin', category: 'register'),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.4,
                                child: RaisedButton(
                                  onPressed: registerButtonPressed,
                                  child: Text(AppInheritedWidget.of(cxt)
                                      .text('Register', category: 'register')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.dispatch(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
