import 'package:flutter/material.dart';

import '../Model/SkillProfile.dart';
import '../Model/User.dart';
import 'ProfileState.dart';

class ProfileView extends StatefulWidget {

  final List<SkillProfile> skillsProfile;
  final User user;

  ProfileView(this.skillsProfile, this.user);

  @override
  createState() => new ProfileState(skillsProfile, user);

}