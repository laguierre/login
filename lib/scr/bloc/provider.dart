

import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

class Provider extends InheritedWidget{

  final loginBloc = LoginBloc();

  Provider({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).loginBloc;
  }
}