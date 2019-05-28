import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hifidelity/app.dart';
import 'package:hifidelity/blocs_test/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(AppScreen());
}
