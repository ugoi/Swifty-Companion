import 'package:swifty_companion/dtos/user_dto.dart' as user_dto;
import 'package:swifty_companion/entities/user_image.dart';

class UserData {
  final ProfileEntity profile;
  final List<SkillEntity> skills;
  final List<ProjectEntity> projects;

  UserData(
      {required this.profile,
      List<SkillEntity>? skills,
      List<ProjectEntity>? projects})
      : skills = skills ?? [],
        projects = projects ?? [];

  factory UserData.fromUserDto(user_dto.UserDto userDto) {
    final profile = ProfileEntity.fromUserDto(userDto);
    final skills = userDto.cursusUsers
        ?.firstWhere((element) => element.grade == "Member")
        .skills
        ?.map((skill) => SkillEntity.fromSkillDto(skill))
        .toList();

    final projects = userDto.projectsUsers
        ?.map((project) => ProjectEntity.fromProjectDto(project))
        .toList();

    return UserData(profile: profile, skills: skills, projects: projects);
  }
}

class ProfileEntity {
  static const String _notFound = "N/A";

  final String login;
  final String firstName;
  final String lastName;
  final String email;
  // final double? level;
  final Level level;
  final String location;
  final UserImage profilePicture;

  ProfileEntity(
      {String? login,
      String? firstName,
      String? lastName,
      String? email,
      Level? level,
      String? location,
      required this.profilePicture})
      : login = login ?? _notFound,
        firstName = firstName ?? _notFound,
        lastName = lastName ?? _notFound,
        email = email ?? _notFound,
        level = level ?? Level(level: 0, maxLevel: 20),
        location = location ?? 'Unavailable';

  factory ProfileEntity.fromUserDto(user_dto.UserDto userDto) {
    const defaultImageUrl = "assets/defaultProfilePicture.png";
    return ProfileEntity(
        login: userDto.login,
        firstName: userDto.firstName,
        lastName: userDto.lastName,
        email: userDto.email,
        level: Level(level: userDto.getLevel(), maxLevel: 20),
        location: userDto.location,
        profilePicture: UserImage(url: userDto.url ?? defaultImageUrl));
  }
}

class SkillEntity {
  static const String _notFound = "N/A";
  final int? id;
  final String name;
  final Level level;

  SkillEntity({this.id, String? name, Level? level})
      : name = name ?? _notFound,
        level = level ?? Level(level: 0, maxLevel: 20);

  factory SkillEntity.fromSkillDto(user_dto.Skill skillDto) {
    return SkillEntity(
        id: skillDto.id,
        name: skillDto.name,
        level: Level(level: skillDto.level, maxLevel: 20));
  }
}

class ProjectEntity {
  static const String _notFound = "N/A";
  final String name;
  final Mark mark;

  ProjectEntity({Mark? mark, String? name})
      : mark = mark ?? Mark(level: 0, maxLevel: 100),
        name = name ?? _notFound;

  factory ProjectEntity.fromProjectDto(user_dto.ProjectsUser projectDto) {
    return ProjectEntity(
        name: projectDto.project?.name,
        mark:
            Mark(level: projectDto.finalMark?.toDouble() ?? 0, maxLevel: 100));
  }
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
