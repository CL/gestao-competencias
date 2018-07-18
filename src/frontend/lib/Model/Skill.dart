class Skill{
  String skillId;
  String skillName;
  double skillRating;
  int totalSubSkills;
  List<SubSkill> subSkills;

  Skill({this.skillName, this.skillRating, this.subSkills, this.totalSubSkills, this.skillId});
}

class SubSkill{
  String subSkillId;
  String subSkillName;
  String associationId;
  double subSkillRating;
  bool subSkillInterest;

  SubSkill({this.subSkillId, this.subSkillName, this.associationId, this.subSkillRating, this.subSkillInterest = false});
}