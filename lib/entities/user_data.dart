import 'package:swifty_companion/dtos/user_dto.dart' as user_dto;
import 'package:swifty_companion/entities/user_image.dart';

class UserData {
  final Profile profile;
  final List<Skill> skills;
  final List<Project> projects;

  UserData(
      {required this.profile, List<Skill>? skills, List<Project>? projects})
      : skills = skills ?? [],
        projects = projects ?? [];

  factory UserData.fromUserDto(user_dto.UserDto userDto) {
    final profile = Profile.fromUserDto(userDto);
    final skills = userDto.cursusUsers
        ?.firstWhere((element) => element.grade == "Member")
        .skills
        ?.map((skill) => Skill.fromSkillDto(skill))
        .toList();

    return UserData(profile: profile, skills: skills, projects: []);
  }
}

class Profile {
  static const String _notFound = "N/A";

  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final double? level;
  final String location;
  final UserImage profilePicture;

  Profile(
      {String? login,
      String? firstName,
      String? lastName,
      String? email,
      this.level,
      String? location,
      required this.profilePicture})
      : login = login ?? _notFound,
        firstName = firstName ?? _notFound,
        lastName = lastName ?? _notFound,
        email = email ?? _notFound,
        location = location ?? _notFound;

  factory Profile.fromUserDto(user_dto.UserDto userDto) {
    const defaultImageUrl = "assets/defaultProfilePicture.png";
    return Profile(
        login: userDto.login,
        firstName: userDto.firstName,
        lastName: userDto.lastName,
        email: userDto.email,
        level: userDto.getLevel(),
        location: userDto.location,
        profilePicture: UserImage(url: userDto.url ?? defaultImageUrl));
  }
}

class Skill {
  static const String _notFound = "N/A";
  final int? id;
  final String name;
  final Level level;

  Skill({this.id, String? name, Level? level})
      : name = name ?? _notFound,
        level = level ?? Level(level: 0, maxLevel: 20);

  factory Skill.fromSkillDto(user_dto.Skill skillDto) {
    return Skill(
        id: skillDto.id,
        name: skillDto.name,
        level: Level(level: skillDto.level, maxLevel: 20));
  }
}

class Project {
  static const String _notFound = "N/A";
  final String name;
  final Mark? mark;

  Project({this.name = _notFound, this.mark});
}

class Level {
  final double level;
  final double maxLevel;

  Level({double? level, double? maxLevel})
      : level = level ?? 0,
        maxLevel = maxLevel ?? 20;

  double toPercentage() {
    return level / maxLevel * 100;
  }

  factory Level.fromPercentage({required double percentage}) {
    return Level(level: percentage, maxLevel: 100);
  }
}

class Mark {
  final double level;
  final double maxLevel;

  Mark({required this.level, required this.maxLevel});

  double toPercentage() {
    return level / maxLevel * 100;
  }

  factory Mark.fromPercentage({required double percentage}) {
    return Mark(level: percentage, maxLevel: 100);
  }
}
