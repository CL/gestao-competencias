import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'package:http/http.dart';

import '../Model/Skill.dart';
import '../Model/User.dart';

import '../Shared/Constants.dart';

class SkillsService {

  String urlUserSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS;

  String urlAllSkills = Constants.URL_BACKEND + Constants.PATH_SKILLS + Constants.PATH_ALL;

  Future<List<Skill>> getUserSkills(User user) async {
    String urlParams = urlUserSkills + "?email="+user.email+"&id="+user.id+"&name="
                      +user.name+"&password="+user.password+"&role=" + user.role;
    Response response = await http.get(urlParams, headers: {"content-type": "application/json"});
    
    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<dynamic> jsonResponse = json.decode(response.body);

    List<Skill> skills = new List<Skill>();

    jsonResponse.forEach((skill) {
      skills.add(new Skill.fromJson(skill));
    });

    return skills;
  }

  Future<List<Skill>> getAllSkills(User user) async {
    String urlParams = urlAllSkills + "?email="+user.email+"&id="+user.id+"&name="
                      +user.name+"&password="+user.password+"&role=" + user.role;
    Response response = await http.get(urlParams, headers: {"content-type": "application/json"});
    
    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<dynamic> jsonResponse = json.decode(response.body);

    List<Skill> skills = new List<Skill>();

    for(Map<String, dynamic> skill in jsonResponse) {
      Skill skillObj = Skill.fromJson(skill);
      skills.add(skillObj);
    }

    return skills;
  }

  Future<bool> saveSkills(List<SubSkill> selectedSkills, User user) async {
    String jsonSkills = json.encode(selectedSkills);
    Response response = await http.post(urlUserSkills, body: jsonSkills, headers: {"content-type": "application/json", "Authorization": "email="+user.email+",signature="+user.password+",id="+user.id});
    return response.body == "True" ? true : false;
  }

  void deleteSkill(Skill skill, User user) {
    String urlParam = urlUserSkills+"?funcionario="+user.id+"&idMacro="+skill.skillId;
    http.delete(urlParam, headers: {"content-type": "application/json", "Authorization": "email="+user.email+",signature="+user.password+",id="+user.id});
  }

  void updateSubskills(List<SubSkill> skills, User user) {
    String jsonSkills = json.encode(skills);
    http.put(urlUserSkills, body: jsonSkills, headers: {"content-type": "application/json", "Authorization": "email="+user.email+",signature="+user.password+",id="+user.id});
  }
}