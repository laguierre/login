import 'package:flutter/material.dart';
import 'package:login/scr/pages/product_page.dart';

import 'scr/bloc/provider.dart';
import 'scr/pages/login_page.dart';
import 'scr/pages/home_page.dart';
import 'scr/pages/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        theme: ThemeData(primaryColor: Colors.deepPurple),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'product': (BuildContext context) => ProductPage(),
          'register': (BuildContext context) => RegisterPage(),
        },
      ),
    );
  }
}
