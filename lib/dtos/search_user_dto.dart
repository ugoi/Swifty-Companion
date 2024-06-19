// To parse this JSON data, do
//
//     final searchUserDto = searchUserDtoFromJson(jsonString);

import 'dart:convert';

List<SearchUserDto> searchUserDtoFromJson(String str) =>
    List<SearchUserDto>.from(
        json.decode(str).map((x) => SearchUserDto.fromJson(x)));

String searchUserDtoToJson(List<SearchUserDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUserDto {
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

  SearchUserDto({
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

  factory SearchUserDto.fromJson(Map<String, dynamic> json) => SearchUserDto(
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
