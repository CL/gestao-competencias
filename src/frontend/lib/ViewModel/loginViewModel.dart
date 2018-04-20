import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:http/http.dart';

import '../Model/User.dart';

import '../global.dart' as globals;

class LoginViewModel {

 static const String BACKEND_LOGIN_URL = "https://539ee9a8.ngrok.io/login/";

  Future<bool> logIn(String email, String password) async {
    String jsonLogin = "{ \"email\": \"" + email + "\", \"password\": \"" + password + "\"}";
    Response response = await http.post(BACKEND_LOGIN_URL, body: jsonLogin, headers: {"content-type": "application/json"});
    if(response.statusCode != 200 || response.body == ""){
      return false;
    }
    
    Map<String, String> jsonResponse = JSON.decode(response.body);

    User user = new User(
      id: jsonResponse["id"].toString(), 
      email: jsonResponse["email"].toString(), 
      name: jsonResponse["name"].toString(), 
      role: jsonResponse["role"].toString()
    );

    if(user.email == email){
      globals.user = user;
      return true;
    }
    return false;
  }
}