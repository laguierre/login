//https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyCg8LuhQvn_CFZlNDV0ySK420ufF5DuY-U';

  Future newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToke': true
    };
    final resp = await http.post(Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'), body: json.encode(authData));
    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);
    if(decodeResp.containsKey('idToken')){
      //TODO
      return {'ok': true, 'token': decodeResp['idToken']};
    }
    else{
      return {'ok': false, 'msj': decodeResp['error']['message']};
    }
  }
}
