import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  final String _signUpUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
  final String _signInUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
  final String _apiKey = "AIzaSyCPOTjunhw9mTPkskRgIKoKqHT0STkIs8w";

  Future<void> _authenticate(
      String email, String password, String signUrlType) async {
    var url = Uri.parse(signUrlType + _apiKey);
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(json.decode(response.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, _signUpUrl);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, _signInUrl);
  }
}
