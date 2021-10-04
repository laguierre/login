//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login/scr/user_preferences/user_preferences.dart';

class UserProvider {
  final String _firebaseToken = 'AIzaSyCg8LuhQvn_CFZlNDV0ySK420ufF5DuY-U';
  final _prefs = new UserPreferences();

  login(String email, String password) async {
    final authData = {
      "email": email,
      "password": password,
      "returnSecureToke": true
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken'),
        body: json.encode(authData));
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    //print('Decode Resp: ${decodeResp}');
    if (decodeResp.containsKey('idToken')) {
      print('ID Token: ${decodeResp['idToken']}');
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'msj': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToke': true
    };
    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
        body: json.encode(authData));
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'msj': decodeResp['error']['message']};
    }
  }
}
