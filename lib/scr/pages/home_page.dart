import 'package:flutter/material.dart';
import 'package:login/scr/bloc/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Email: ${bloc.email}'),
              Divider(),
              Text('Password: ${bloc.password}'),
            ],
        ),
      ),
    ));
  }
}
