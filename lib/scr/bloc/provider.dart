import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance = new Provider();
  final loginBloc = LoginBloc();

  /*Provider({Key? key, Widget? child}) : super(key: key, child: child!) {
    if (_instance == null) {
      _instance = Provider._internal(key: key, child: child!);
    }
    //return _instance;
  }
  Provider._internal({Key? key, Widget? child})
      : super(key: key, child: child!);*/
  Provider({Key? key, Widget? child}) : super(key: key, child: child!);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .loginBloc;
  }
}
