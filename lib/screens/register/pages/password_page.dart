import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/redirect_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/register_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/screens/register/pages/wallet_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rxdart/rxdart.dart';

class PasswordPage extends StatefulWidget {
  final String _userEmail;

  PasswordPage({Key key, @required String email})
      : assert(email != null),
        _userEmail = email,
        super(key: key);
  @override
  State createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated => _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _passwordController.addListener(_onPasswordChanged);
    _emailController.text = widget._userEmail;
  }

  // void continueButtonPressed() {
  //   Navigator.of(context).pushNamed('register/wallet');
  // }

  Widget buildPasswordSection(BuildContext cxt) {
    return BlocBuilder(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          return Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  'Create a password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Please enter a password below. It must be between 8 and 24 characters and contain at least one number and symbol.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Stack(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        autocorrect: false,
                        autovalidate: true,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                        style: TextStyle(color: Colors.white),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            showPassword ? MdiIcons.eyeOff : MdiIcons.eye,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: RaisedButton(
                    child: Text('CONTINUE'),
                    onPressed: (isRegisterButtonEnabled(state))
                        ? _onFormSubmitted
                        : null,
                  ),
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext cxt) {
    return BlocListener(
      bloc: _registerBloc,
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          BlocProvider.of<RedirectBloc>(context).dispatch(NavRegister3());
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return WalletPage();
          // }));
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(
                'assets/images/large_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: buildPasswordSection(cxt),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.dispatch(Submitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
