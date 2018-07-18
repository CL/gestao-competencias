import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'package:http/http.dart';

import '../Model/Skill.dart';
import '../Model/User.dart';

import '../Shared/Constants.dart';

class SkillsService {

  String urlGetUserSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS;

  String urlGetAllSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS + Constants.PATH_ALL;

  Future<List<Skill>> getUserSkills(User user) async {
    Response response = await http.get(urlGetUserSkills, headers: {"content-type": "application/json", 
                                                                   "email": user.email, 
                                                                   "id": user.id,
                                                                   "name": user.name,
                                                                   "password": user.password,
                                                                   "role": user.role});
    
    /*if(response.statusCode != 200 || response.body == ""){
      return [];
    }*/
    return [];

    List<Map<String, String>> jsonResponse = JSON.decode(response.body);

    List<Skill> skills = new List<Skill>();

    jsonResponse.forEach((skill) {
      
    });

    return skills;
  }

  Future<List<Skill>> getAllSkills(User user) async {
    Response response = await http.get(urlGetUserSkills, headers: {"content-type": "application/json", 
                                                                   "email": user.email, 
                                                                   "id": user.id,
                                                                   "name": user.name,
                                                                   "password": user.password,
                                                                   "role": user.role});
    
    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<Map<String, String>> jsonResponse = JSON.decode(response.body);

    List<Skill> skills = new List<Skill>();

    jsonResponse.forEach((skill) {
      
    });

    return skills;
  }
}