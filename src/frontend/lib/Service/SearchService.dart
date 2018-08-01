import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'package:http/http.dart';

import '../Model/User.dart';

import '../Shared/Constants.dart';

class SearchService {

  String urlAllUsers = Constants.URL_BACKEND + Constants.PATH_SEARCH;
  String urlUsersCategory = Constants.URL_BACKEND + Constants.PATH_SEARCH + Constants.PATH_SKILLS;

  Future<List<User>> getAllUsers(User user) async{
    String urlParams = urlAllUsers + "?email="+user.email+"&password="+user.password;
    Response response = await http.get(urlParams, headers: {"content-type": "application/json"});
    
    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<dynamic> jsonResponse = json.decode(response.body);

    List<User> users = new List<User>();

    for(Map<String, dynamic> user in jsonResponse) {
      User userObj = User.fromJson(user);
      users.add(userObj);
    }

    return users;
  }

  Future<List<User>> getUsersCategory(User user) async{
    String urlParams = urlUsersCategory + "?email="+user.email+"&password="+user.password;
    Response response = await http.get(urlParams, headers: {"content-type": "application/json"});

    if(response.statusCode != 200 || response.body == ""){
      return [];
    }

    List<dynamic> jsonResponse = json.decode(response.body);

    List<User> users = new List<User>();

    for(Map<String, dynamic> user in jsonResponse) {
      User userObj = User.fromJson(user);
      users.add(userObj);
    }

    return users;
  }
}