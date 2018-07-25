import '../Model/Skill.dart';
import '../Model/User.dart';

class ContextData {
  User user;
  List<Skill> userSkills;
  List<Skill> allSkills;
  
  ContextData(this.user, this.userSkills, this.allSkills);
}