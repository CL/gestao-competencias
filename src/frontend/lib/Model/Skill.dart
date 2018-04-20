class Skill{
  String skillId;
  String skillName;
  double skillRating;
  int totalSubSkills;
  List<SubSkill> subSkills;

  Skill({this.skillName, this.skillRating, this.subSkills, this.totalSubSkills, this.skillId});
}

class SubSkill{
  String subSkillName;
  double subSkillRating;

  SubSkill({this.subSkillName, this.subSkillRating});
}