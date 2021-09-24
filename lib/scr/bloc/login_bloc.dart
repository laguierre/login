import 'dart:async';
import 'package:login/scr/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  ///Recover the data from Stream///

  Stream<String> get emailStream    => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );

   Stream<bool> get formValidStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  ///Add value to Stream///
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;

/*dispose(){
    _emailController?.close();
    _passwordController?.close();
  }*/
}
