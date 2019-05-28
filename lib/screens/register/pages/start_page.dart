import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hifidelity/blocs_test/authentication_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/redirect_bloc/bloc.dart';
import 'package:hifidelity/blocs_test/register_bloc/bloc.dart';
import 'package:hifidelity/components/app_inherited_widget.dart';
import 'package:hifidelity/screens/register/pages/password_page.dart';

class StartPage extends StatefulWidget {
  @override
  State createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated => _emailController.text.isNotEmpty;

  bool isContinueButtonEnabled(RegisterState state) {
    return state.isEmailValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
  }

  void continueButtonPressed() {
    BlocProvider.of<RedirectBloc>(context)
        .dispatch(NavRegister2(email: _emailController.text));
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return PasswordPage(email: _emailController.text);
    // }));
  }

  Widget buildRegisterSection(BuildContext cxt) {
    return BlocBuilder(
      bloc: _registerBloc,
      builder: (BuildContext context, RegisterState state) {
        return Form(
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  AppInheritedWidget.of(cxt)
                      .text('RegisterText', category: 'register'),
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
                      .text('RegisterSubtext', category: 'register'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              // FractionallySizedBox(
              //   widthFactor: 0.8,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 8),
              //     child: TextFormField(
              //       decoration: InputDecoration(
              //         hintText: AppInheritedWidget.of(cxt)
              //             .text('Name', category: 'register'),
              //         hintStyle: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppInheritedWidget.of(cxt)
                          .text('Email', category: 'register'),
                    ),
                    style: TextStyle(color: Colors.white),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                ),
              ),
              Expanded(child: Container()),
              Center(
                child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: RaisedButton(
                      onPressed: isContinueButtonEnabled(state)
                          ? continueButtonPressed
                          : null,
                      child: Text('CONTINUE'),
                    )),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        );
      },
    );
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
          Navigator.of(context).pop();
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
            child: buildRegisterSection(cxt),
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
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }
}
