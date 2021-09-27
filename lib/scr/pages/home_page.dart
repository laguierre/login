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
          backgroundColor: Colors.deepPurple,
          title: Text('Home Page'),
        ),
        body: /*Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Email: ${bloc.email}'),
              Divider(),
              Text('Password: ${bloc.password}'),
            ],
        ),*/
            Container(),
        floatingActionButton: _fab(context),
      ),
    );
  }

  _fab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'product'));
  }
}
