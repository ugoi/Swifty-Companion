// This code was generated with https://app.quicktype.io
// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

String userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  int? id;
  String? email;
  String? login;
  String? firstName;
  String? lastName;
  String? usualFullName;
  dynamic usualFirstName;
  String? url;
  String? phone;
  String? displayname;
  String? kind;
  Image? image;
  bool? staff;
  int? correctionPoint;
  String? poolMonth;
  String? poolYear;
  dynamic location;
  int? wallet;
  DateTime? anonymizeDate;
  DateTime? dataErasureDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic alumnizedAt;
  bool? alumni;
  bool? active;
  List<dynamic>? groups;
  List<CursusUser>? cursusUsers;
  List<ProjectsUser>? projectsUsers;
  List<LanguagesUser>? languagesUsers;
  List<Achievement>? achievements;
  List<Title>? titles;
  List<TitlesUser>? titlesUsers;
  List<dynamic>? partnerships;
  List<dynamic>? patroned;
  List<dynamic>? patroning;
  List<dynamic>? expertisesUsers;
  List<dynamic>? roles;
  List<Campus>? campus;
  List<CampusUser>? campusUsers;

  UserDto({
    this.id,
    this.email,
    this.login,
    this.firstName,
    this.lastName,
    this.usualFullName,
    this.usualFirstName,
    this.url,
    this.phone,
    this.displayname,
    this.kind,
    this.image,
    this.staff,
    this.correctionPoint,
    this.poolMonth,
    this.poolYear,
    this.location,
    this.wallet,
    this.anonymizeDate,
    this.dataErasureDate,
    this.createdAt,
    this.updatedAt,
    this.alumnizedAt,
    this.alumni,
    this.active,
    this.groups,
    this.cursusUsers,
    this.projectsUsers,
    this.languagesUsers,
    this.achievements,
    this.titles,
    this.titlesUsers,
    this.partnerships,
    this.patroned,
    this.patroning,
    this.expertisesUsers,
    this.roles,
    this.campus,
    this.campusUsers,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"],
        email: json["email"],
        login: json["login"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        usualFullName: json["usual_full_name"],
        usualFirstName: json["usual_first_name"],
        url: json["url"],
        phone: json["phone"],
        displayname: json["displayname"],
        kind: json["kind"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        staff: json["staff?"],
        correctionPoint: json["correction_point"],
        poolMonth: json["pool_month"],
        poolYear: json["pool_year"],
        location: json["location"],
        wallet: json["wallet"],
        anonymizeDate: json["anonymize_date"] == null
            ? null
            : DateTime.parse(json["anonymize_date"]),
        dataErasureDate: json["data_erasure_date"] == null
            ? null
            : DateTime.parse(json["data_erasure_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        alumnizedAt: json["alumnized_at"],
        alumni: json["alumni?"],
        active: json["active?"],
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        cursusUsers: json["cursus_users"] == null
            ? []
            : List<CursusUser>.from(
                json["cursus_users"]!.map((x) => CursusUser.fromJson(x))),
        projectsUsers: json["projects_users"] == null
            ? []
            : List<ProjectsUser>.from(
                json["projects_users"]!.map((x) => ProjectsUser.fromJson(x))),
        languagesUsers: json["languages_users"] == null
            ? []
            : List<LanguagesUser>.from(
                json["languages_users"]!.map((x) => LanguagesUser.fromJson(x))),
        achievements: json["achievements"] == null
            ? []
            : List<Achievement>.from(
                json["achievements"]!.map((x) => Achievement.fromJson(x))),
        titles: json["titles"] == null
            ? []
            : List<Title>.from(json["titles"]!.map((x) => Title.fromJson(x))),
        titlesUsers: json["titles_users"] == null
            ? []
            : List<TitlesUser>.from(
                json["titles_users"]!.map((x) => TitlesUser.fromJson(x))),
        partnerships: json["partnerships"] == null
            ? []
            : List<dynamic>.from(json["partnerships"]!.map((x) => x)),
        patroned: json["patroned"] == null
            ? []
            : List<dynamic>.from(json["patroned"]!.map((x) => x)),
        patroning: json["patroning"] == null
            ? []
            : List<dynamic>.from(json["patroning"]!.map((x) => x)),
        expertisesUsers: json["expertises_users"] == null
            ? []
            : List<dynamic>.from(json["expertises_users"]!.map((x) => x)),
        roles: json["roles"] == null
            ? []
            : List<dynamic>.from(json["roles"]!.map((x) => x)),
        campus: json["campus"] == null
            ? []
            : List<Campus>.from(json["campus"]!.map((x) => Campus.fromJson(x))),
        campusUsers: json["campus_users"] == null
            ? []
            : List<CampusUser>.from(
                json["campus_users"]!.map((x) => CampusUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "login": login,
        "first_name": firstName,
        "last_name": lastName,
        "usual_full_name": usualFullName,
        "usual_first_name": usualFirstName,
        "url": url,
        "phone": phone,
        "displayname": displayname,
        "kind": kind,
        "image": image?.toJson(),
        "staff?": staff,
        "correction_point": correctionPoint,
        "pool_month": poolMonth,
        "pool_year": poolYear,
        "location": location,
        "wallet": wallet,
        "anonymize_date": anonymizeDate?.toIso8601String(),
        "data_erasure_date": dataErasureDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "alumnized_at": alumnizedAt,
        "alumni?": alumni,
        "active?": active,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "cursus_users": cursusUsers == null
            ? []
            : List<dynamic>.from(cursusUsers!.map((x) => x.toJson())),
        "projects_users": projectsUsers == null
            ? []
            : List<dynamic>.from(projectsUsers!.map((x) => x.toJson())),
        "languages_users": languagesUsers == null
            ? []
            : List<dynamic>.from(languagesUsers!.map((x) => x.toJson())),
        "achievements": achievements == null
            ? []
            : List<dynamic>.from(achievements!.map((x) => x.toJson())),
        "titles": titles == null
            ? []
            : List<dynamic>.from(titles!.map((x) => x.toJson())),
        "titles_users": titlesUsers == null
            ? []
            : List<dynamic>.from(titlesUsers!.map((x) => x.toJson())),
        "partnerships": partnerships == null
            ? []
            : List<dynamic>.from(partnerships!.map((x) => x)),
        "patroned":
            patroned == null ? [] : List<dynamic>.from(patroned!.map((x) => x)),
        "patroning": patroning == null
            ? []
            : List<dynamic>.from(patroning!.map((x) => x)),
        "expertises_users": expertisesUsers == null
            ? []
            : List<dynamic>.from(expertisesUsers!.map((x) => x)),
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "campus": campus == null
            ? []
            : List<dynamic>.from(campus!.map((x) => x.toJson())),
        "campus_users": campusUsers == null
            ? []
            : List<dynamic>.from(campusUsers!.map((x) => x.toJson())),
      };

// Below are my own modifications, the code above in this class is autogenerated.

  /// gets level form cursus_users
  double? getLevel() {
    final cursusUsers = this.cursusUsers;
    if (cursusUsers == null) return null;
    final cursusUser = cursusUsers.firstWhere(
        (element) => element.grade != null,
        orElse: () => CursusUser());
    return cursusUser.level;
  }
}

class Achievement {
  int? id;
  String? name;
  String? description;
  String? tier;
  Kind? kind;
  bool? visible;
  String? image;
  int? nbrOfSuccess;
  String? usersUrl;

  Achievement({
    this.id,
    this.name,
    this.description,
    this.tier,
    this.kind,
    this.visible,
    this.image,
    this.nbrOfSuccess,
    this.usersUrl,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        tier: json["tier"],
        kind: kindValues.map[json["kind"]]!,
        visible: json["visible"],
        image: json["image"],
        nbrOfSuccess: json["nbr_of_success"],
        usersUrl: json["users_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "tier": tier,
        "kind": kindValues.reverse[kind],
        "visible": visible,
        "image": image,
        "nbr_of_success": nbrOfSuccess,
        "users_url": usersUrl,
      };
}

enum Kind { PEDAGOGY, PROJECT, SCOLARITY, SOCIAL }

final kindValues = EnumValues({
  "pedagogy": Kind.PEDAGOGY,
  "project": Kind.PROJECT,
  "scolarity": Kind.SCOLARITY,
  "social": Kind.SOCIAL
});

class Campus {
  int? id;
  String? name;
  String? timeZone;
  Language? language;
  int? usersCount;
  int? vogsphereId;
  String? country;
  String? address;
  String? zip;
  String? city;
  String? website;
  String? facebook;
  String? twitter;
  bool? active;
  bool? public;
  String? emailExtension;
  bool? defaultHiddenPhone;

  Campus({
    this.id,
    this.name,
    this.timeZone,
    this.language,
    this.usersCount,
    this.vogsphereId,
    this.country,
    this.address,
    this.zip,
    this.city,
    this.website,
    this.facebook,
    this.twitter,
    this.active,
    this.public,
    this.emailExtension,
    this.defaultHiddenPhone,
  });

  factory Campus.fromJson(Map<String, dynamic> json) => Campus(
        id: json["id"],
        name: json["name"],
        timeZone: json["time_zone"],
        language: json["language"] == null
            ? null
            : Language.fromJson(json["language"]),
        usersCount: json["users_count"],
        vogsphereId: json["vogsphere_id"],
        country: json["country"],
        address: json["address"],
        zip: json["zip"],
        city: json["city"],
        website: json["website"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        active: json["active"],
        public: json["public"],
        emailExtension: json["email_extension"],
        defaultHiddenPhone: json["default_hidden_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time_zone": timeZone,
        "language": language?.toJson(),
        "users_count": usersCount,
        "vogsphere_id": vogsphereId,
        "country": country,
        "address": address,
        "zip": zip,
        "city": city,
        "website": website,
        "facebook": facebook,
        "twitter": twitter,
        "active": active,
        "public": public,
        "email_extension": emailExtension,
        "default_hidden_phone": defaultHiddenPhone,
      };
}

class Language {
  int? id;
  String? name;
  String? identifier;
  DateTime? createdAt;
  DateTime? updatedAt;

  Language({
    this.id,
    this.name,
    this.identifier,
    this.createdAt,
    this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        identifier: json["identifier"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "identifier": identifier,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class CampusUser {
  int? id;
  int? userId;
  int? campusId;
  bool? isPrimary;
  DateTime? createdAt;
  DateTime? updatedAt;

  CampusUser({
    this.id,
    this.userId,
    this.campusId,
    this.isPrimary,
    this.createdAt,
    this.updatedAt,
  });

  factory CampusUser.fromJson(Map<String, dynamic> json) => CampusUser(
        id: json["id"],
        userId: json["user_id"],
        campusId: json["campus_id"],
        isPrimary: json["is_primary"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "campus_id": campusId,
        "is_primary": isPrimary,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class CursusUser {
  String? grade;
  double? level;
  List<Skill>? skills;
  dynamic blackholedAt;
  int? id;
  DateTime? beginAt;
  DateTime? endAt;
  int? cursusId;
  bool? hasCoalition;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Cursus? cursus;

  CursusUser({
    this.grade,
    this.level,
    this.skills,
    this.blackholedAt,
    this.id,
    this.beginAt,
    this.endAt,
    this.cursusId,
    this.hasCoalition,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.cursus,
  });

  factory CursusUser.fromJson(Map<String, dynamic> json) => CursusUser(
        grade: json["grade"],
        level: json["level"]?.toDouble(),
        skills: json["skills"] == null
            ? []
            : List<Skill>.from(json["skills"]!.map((x) => Skill.fromJson(x))),
        blackholedAt: json["blackholed_at"],
        id: json["id"],
        beginAt:
            json["begin_at"] == null ? null : DateTime.parse(json["begin_at"]),
        endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        cursusId: json["cursus_id"],
        hasCoalition: json["has_coalition"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        cursus: json["cursus"] == null ? null : Cursus.fromJson(json["cursus"]),
      );

  Map<String, dynamic> toJson() => {
        "grade": grade,
        "level": level,
        "skills": skills == null
            ? []
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
        "blackholed_at": blackholedAt,
        "id": id,
        "begin_at": beginAt?.toIso8601String(),
        "end_at": endAt?.toIso8601String(),
        "cursus_id": cursusId,
        "has_coalition": hasCoalition,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "cursus": cursus?.toJson(),
      };
}

class Cursus {
  int? id;
  DateTime? createdAt;
  String? name;
  String? slug;
  String? kind;

  Cursus({
    this.id,
    this.createdAt,
    this.name,
    this.slug,
    this.kind,
  });

  factory Cursus.fromJson(Map<String, dynamic> json) => Cursus(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        name: json["name"],
        slug: json["slug"],
        kind: json["kind"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "slug": slug,
        "kind": kind,
      };
}

class Skill {
  int? id;
  String? name;
  double? level;

  Skill({
    this.id,
    this.name,
    this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        name: json["name"],
        level: json["level"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
      };
}

class User {
  int? id;
  String? email;
  String? login;
  String? firstName;
  String? lastName;
  String? usualFullName;
  dynamic usualFirstName;
  String? url;
  String? phone;
  String? displayname;
  String? kind;
  Image? image;
  bool? staff;
  int? correctionPoint;
  String? poolMonth;
  String? poolYear;
  dynamic location;
  int? wallet;
  DateTime? anonymizeDate;
  DateTime? dataErasureDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic alumnizedAt;
  bool? alumni;
  bool? active;

  User({
    this.id,
    this.email,
    this.login,
    this.firstName,
    this.lastName,
    this.usualFullName,
    this.usualFirstName,
    this.url,
    this.phone,
    this.displayname,
    this.kind,
    this.image,
    this.staff,
    this.correctionPoint,
    this.poolMonth,
    this.poolYear,
    this.location,
    this.wallet,
    this.anonymizeDate,
    this.dataErasureDate,
    this.createdAt,
    this.updatedAt,
    this.alumnizedAt,
    this.alumni,
    this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        login: json["login"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        usualFullName: json["usual_full_name"],
        usualFirstName: json["usual_first_name"],
        url: json["url"],
        phone: json["phone"],
        displayname: json["displayname"],
        kind: json["kind"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        staff: json["staff?"],
        correctionPoint: json["correction_point"],
        poolMonth: json["pool_month"],
        poolYear: json["pool_year"],
        location: json["location"],
        wallet: json["wallet"],
        anonymizeDate: json["anonymize_date"] == null
            ? null
            : DateTime.parse(json["anonymize_date"]),
        dataErasureDate: json["data_erasure_date"] == null
            ? null
            : DateTime.parse(json["data_erasure_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        alumnizedAt: json["alumnized_at"],
        alumni: json["alumni?"],
        active: json["active?"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "login": login,
        "first_name": firstName,
        "last_name": lastName,
        "usual_full_name": usualFullName,
        "usual_first_name": usualFirstName,
        "url": url,
        "phone": phone,
        "displayname": displayname,
        "kind": kind,
        "image": image?.toJson(),
        "staff?": staff,
        "correction_point": correctionPoint,
        "pool_month": poolMonth,
        "pool_year": poolYear,
        "location": location,
        "wallet": wallet,
        "anonymize_date": anonymizeDate?.toIso8601String(),
        "data_erasure_date": dataErasureDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "alumnized_at": alumnizedAt,
        "alumni?": alumni,
        "active?": active,
      };
}

class Image {
  String? link;
  Versions? versions;

  Image({
    this.link,
    this.versions,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        link: json["link"],
        versions: json["versions"] == null
            ? null
            : Versions.fromJson(json["versions"]),
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "versions": versions?.toJson(),
      };
}

class Versions {
  String? large;
  String? medium;
  String? small;
  String? micro;

  Versions({
    this.large,
    this.medium,
    this.small,
    this.micro,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        micro: json["micro"],
      );

  Map<String, dynamic> toJson() => {
        "large": large,
        "medium": medium,
        "small": small,
        "micro": micro,
      };
}

class LanguagesUser {
  int? id;
  int? languageId;
  int? userId;
  int? position;
  DateTime? createdAt;

  LanguagesUser({
    this.id,
    this.languageId,
    this.userId,
    this.position,
    this.createdAt,
  });

  factory LanguagesUser.fromJson(Map<String, dynamic> json) => LanguagesUser(
        id: json["id"],
        languageId: json["language_id"],
        userId: json["user_id"],
        position: json["position"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_id": languageId,
        "user_id": userId,
        "position": position,
        "created_at": createdAt?.toIso8601String(),
      };
}

class ProjectsUser {
  int? id;
  int? occurrence;
  int? finalMark;
  Status? status;
  bool? validated;
  int? currentTeamId;
  Project? project;
  List<int>? cursusIds;
  DateTime? markedAt;
  bool? marked;
  DateTime? retriableAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProjectsUser({
    this.id,
    this.occurrence,
    this.finalMark,
    this.status,
    this.validated,
    this.currentTeamId,
    this.project,
    this.cursusIds,
    this.markedAt,
    this.marked,
    this.retriableAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectsUser.fromJson(Map<String, dynamic> json) => ProjectsUser(
        id: json["id"],
        occurrence: json["occurrence"],
        finalMark: json["final_mark"],
        status: statusValues.map[json["status"]]!,
        validated: json["validated?"],
        currentTeamId: json["current_team_id"],
        project:
            json["project"] == null ? null : Project.fromJson(json["project"]),
        cursusIds: json["cursus_ids"] == null
            ? []
            : List<int>.from(json["cursus_ids"]!.map((x) => x)),
        markedAt: json["marked_at"] == null
            ? null
            : DateTime.parse(json["marked_at"]),
        marked: json["marked"],
        retriableAt: json["retriable_at"] == null
            ? null
            : DateTime.parse(json["retriable_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "occurrence": occurrence,
        "final_mark": finalMark,
        "status": statusValues.reverse[status],
        "validated?": validated,
        "current_team_id": currentTeamId,
        "project": project?.toJson(),
        "cursus_ids": cursusIds == null
            ? []
            : List<dynamic>.from(cursusIds!.map((x) => x)),
        "marked_at": markedAt?.toIso8601String(),
        "marked": marked,
        "retriable_at": retriableAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Project {
  int? id;
  String? name;
  String? slug;
  int? parentId;

  Project({
    this.id,
    this.name,
    this.slug,
    this.parentId,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent_id": parentId,
      };
}

enum Status { FINISHED, IN_PROGRESS }

final statusValues = EnumValues(
    {"finished": Status.FINISHED, "in_progress": Status.IN_PROGRESS});

class Title {
  int? id;
  String? name;

  Title({
    this.id,
    this.name,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TitlesUser {
  int? id;
  int? userId;
  int? titleId;
  bool? selected;
  DateTime? createdAt;
  DateTime? updatedAt;

  TitlesUser({
    this.id,
    this.userId,
    this.titleId,
    this.selected,
    this.createdAt,
    this.updatedAt,
  });

  factory TitlesUser.fromJson(Map<String, dynamic> json) => TitlesUser(
        id: json["id"],
        userId: json["user_id"],
        titleId: json["title_id"],
        selected: json["selected"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title_id": titleId,
        "selected": selected,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
