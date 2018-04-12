class SkillProfile{
  String skillName;
  double skillRating;
  int totalSubSkills;
  List<SubSkill> subSkills;

  SkillProfile({this.skillName, this.skillRating, this.subSkills, this.totalSubSkills});
}

class SubSkill{
  String subSkillName;
  double subSkillRating;

  SubSkill({this.subSkillName, this.subSkillRating});
}