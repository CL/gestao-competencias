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
    String urlParams = urlGetAllSkills + "?email="+user.email+"&id="+user.id+"&name="
                      +user.name+"&password="+user.password+"&role=" + user.role;
    Response response = await http.get(urlParams, headers: {"content-type": "application/json"});
    
    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<dynamic> jsonResponse = JSON.decode(response.body);

    List<Skill> skills = new List<Skill>();

    for(Map<String, dynamic> skill in jsonResponse) {
      Skill skillObj = new Skill(
        skillId: skill["skill_id"].toString(),
        skillName: skill["skill_name"].toString(),
        skillRating: double.parse(skill["skill_rating"].toString()),
        totalSubSkills: int.parse(skill["total_sub_skills"].toString())
      );

      List<SubSkill> subskillList = [];

      skill["sub_skills"].forEach((subskill) {
        SubSkill subSkillObj = new SubSkill(
          subSkillId: subskill["subskill_id"].toString(),
          subSkillInterest: subskill["sub_skill_interest"],
          subSkillName: subskill["subskill_name"].toString(),
          subSkillRating: double.parse(subskill["subskill_rating"].toString()),
          associationId: subskill["subskill_assoc_id"].toString()
        );

        subskillList.add(subSkillObj);
      });

      skillObj.subSkills = subskillList;

      skills.add(skillObj);
    }

    return skills;
  }
}