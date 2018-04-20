import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:http/http.dart';

class LoginViewModel {

  String BACKEND_LOGIN_URL = "";

  Future<bool> logIn(String email, String password) async {
     Response response = await http.post(BACKEND_LOGIN_URL, body: {"email": email, "password": password});
     LoginUser user = JSON.decode(response.body);
     if(user.email == email){
       return true;
     }
     return false;
  }
}

class LoginUser{
  String id;
  String email;
  String name;
  String role;

  LoginUser(this.id, this.email, this.name, this.role);
}