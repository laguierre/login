import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/scr/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          _background(size),
          _loginForm(context, size),
        ],
      ),
    ));
  }

  Widget _background(Size size) {
    final _backPurple = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0),
        ],
      )),
    );
    final _circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: BorderRadius.circular(50),
      ),
    );
    return Stack(
      children: [
        _backPurple,
        Positioned(top: 90, left: 30.0, child: _circle),
        Positioned(top: -40.0, left: -30.0, child: _circle),
        Positioned(top: -50.0, right: -10.0, child: _circle),
        Positioned(top: 120.0, right: 20.0, child: _circle),
        Positioned(top: -50.0, right: -20.0, child: _circle),
        Container(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: const [
              Icon(Icons.person_pin_circle, size: 100.0, color: Colors.white),
              SizedBox(width: double.infinity, height: 10.0),
              Text(
                'Leandro Aguierre',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context, Size size) {
    final bloc = Provider.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.28,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 55.0),
                _email(bloc),
                SizedBox(height: 30.0),
                _pass(bloc),
                SizedBox(height: 30.0),
                _btn(),
              ],
            ),
          ),
          Text('Forgot the password?'),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _email(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                  hintText: 'example@email.com',
                  labelText: 'Email',
                  counterText: snapshot.data,
                  errorText: snapshot.error.toString()),
              onChanged: (value) => bloc.changeEmail,
            ),
          );
        });
  }

  Widget _pass(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Password',
                counterText: snapshot.data,
                errorText: snapshot.error.toString(),
              ),
              onChanged: (value) => bloc.passwordStream,
            ),
          );
        });
  }

  Widget _btn() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
        //shape: MaterialStateProperty.
      ),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
        child:
            Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
