import 'dart:async';
import 'package:login/scr/bloc/validators.dart';

class LoginBloc with Validators{
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  ///Recover the data from Stream///
  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  ///Add value to Stream///
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  /*dispose(){
    _emailController?.close();
    _passwordController?.close();
  }*/
}