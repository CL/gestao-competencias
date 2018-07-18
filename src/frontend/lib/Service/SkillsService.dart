import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart';

import '../Model/User.dart';

import '../Shared/Constants.dart';

import '../Shared/global.dart' as globals;

class SkillsService {

  String urlGetUserSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS;

  String urlGetAllSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS + Constants.PATH_ALL;

  Future<bool> getUserSkills(User user) async {
    JsonEncoder encoder = new JsonEncoder(user);

    String jsonUser = encoder.convert(user);

    Response response = await http.post(urlGetUserSkills, body: jsonUser, headers: {"content-type": "application/json"});
    
    if(response.statusCode != 200 || response.body == ""){
      return false;
    }
    Map<String, String> jsonResponse = JSON.decode(response.body);

    User user = new User(
      id: jsonResponse["id"].toString(), 
      email: jsonResponse["email"].toString(), 
      name: jsonResponse["name"].toString(), 
      role: jsonResponse["role"].toString(),
      password: jsonResponse["password"].toString()
    );


    if(user.email == email){
      globals.user = user;
      return true;
    }
    return false;
  }
}