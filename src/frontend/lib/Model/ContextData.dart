import '../Model/Skill.dart';
import '../Model/User.dart';

class ContextData {
  User user;
  List<Skill> userSkills;
  List<Skill> allSkills;
  List<User> filteredUsers;
  bool isAllUsers;
  
  ContextData(this.user, this.userSkills, this.allSkills, {this.filteredUsers, this.isAllUsers});
}