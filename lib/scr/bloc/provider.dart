import 'package:flutter/material.dart';

import 'package:login/scr/bloc/product_bloc.dart';
import 'login_bloc.dart';
export 'login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final _productBloc = ProductBloc();

  ///Con retención de datos
  /*static Provider _instance = Provider();
  factory Provider({Key? key, Widget? child})  {
    if (_instance == null) {
      _instance = Provider._internal(key: key, child: child!);
    }
    return _instance;
  }
  Provider._internal({Key? key, Widget? child})
      : super(key: key, child: child!);*/

  ///Sin retención de datos///
  Provider({Key? key, Widget? child}) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .loginBloc;
  }

  ///productBloc != _productBloc
  static ProductBloc productBloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        ._productBloc;
  }
}
