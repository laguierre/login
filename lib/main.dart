import 'package:flutter/material.dart';

import 'scr/bloc/provider.dart';
import 'scr/pages/login_page.dart';
import 'scr/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Form Validation',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
        },

      ),
    );
  }
}
