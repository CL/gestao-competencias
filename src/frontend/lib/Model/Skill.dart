class Skill{
  String skillId;
  String skillName;
  double skillRating;
  int totalSubSkills;
  List<SubSkill> subSkills;

  Skill({this.skillName, this.skillRating, this.subSkills, this.totalSubSkills, this.skillId});

  Skill.fromJson(Map<String, dynamic> json) {
    skillId = json["skill_id"].toString();
    skillName = json["skill_name"].toString();
    skillRating = double.parse(json["skill_rating"].toString());
    totalSubSkills = int.parse(json["total_sub_skills"].toString());

    List<SubSkill> subskillList = [];
    json["sub_skills"].forEach((subskill) {
        SubSkill subSkillObj = new SubSkill.fromJson(subskill);
        subskillList.add(subSkillObj);
    });

    subSkills = subskillList;
  }

  Map<String, dynamic> toJson() => {
    "skill_id": skillId,
    "skill_name": skillName,
    "skill_rating": skillRating,
    "total_sub_skills": totalSubSkills,
    "sub_skills": getSubskillsMap() 
  };

  List<Map<String, dynamic>> getSubskillsMap() {
    
    List<Map<String, dynamic>> subSkillsDicts = [];

    subSkills.forEach((subskill) {
      subSkillsDicts.add(subskill.toJson());
    });

    return subSkillsDicts;
  }
}

class SubSkill{
  String subSkillId;
  String subSkillName;
  String associationId;
  double subSkillRating;
  bool subSkillInterest;

  SubSkill({this.subSkillId, this.subSkillName, this.associationId, this.subSkillRating, this.subSkillInterest = false});

  SubSkill.fromJson(Map<String, dynamic> json) {
      subSkillId = json["subskill_id"].toString();
      subSkillInterest = json["sub_skill_interest"];
      subSkillName = json["subskill_name"].toString();
      subSkillRating = double.parse(json["subskill_rating"].toString());
      associationId = json["subskill_assoc_id"].toString();
  }

  Map<String, dynamic> toJson() => {
    "subskill_id": subSkillId,
    "sub_skill_interest": subSkillInterest,
    "subskill_name": subSkillName,
    "subskill_rating": subSkillRating,
    "subskill_assoc_id": associationId
  };
}