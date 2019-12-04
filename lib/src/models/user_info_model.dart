// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    int id;
    String lastName;
    String role;
    dynamic nia;
    dynamic telephone;
    String avatar;
    String lastConnection;
    String firstName;
    String email;
    String dni;
    String username;
    String accessToken;
    String importCode;
    List<dynamic> degrees;
    List<dynamic> subjects;
    List<dynamic> subjectsTeacher;
    List<dynamic> groups;
    List<dynamic> schools;
    List<Disclaimer> disclaimers;
    dynamic expirationTokenTime;
    int status;
    bool acceptCommercialMessage;

    UserInfoModel({
        this.id,
        this.lastName,
        this.role,
        this.nia,
        this.telephone,
        this.avatar,
        this.lastConnection,
        this.firstName,
        this.email,
        this.dni,
        this.username,
        this.accessToken,
        this.importCode,
        this.degrees,
        this.subjects,
        this.subjectsTeacher,
        this.groups,
        this.schools,
        this.disclaimers,
        this.expirationTokenTime,
        this.status,
        this.acceptCommercialMessage,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        lastName: json["lastName"],
        role: json["role"],
        nia: json["nia"],
        telephone: json["telephone"],
        avatar: json["avatar"],
        lastConnection: json["lastConnection"],
        firstName: json["firstName"],
        email: json["email"],
        dni: json["dni"],
        username: json["username"],
        accessToken: json["accessToken"],
        importCode: json["importCode"],
        degrees: List<dynamic>.from(json["degrees"].map((x) => x)),
        subjects: List<dynamic>.from(json["subjects"].map((x) => x)),
        subjectsTeacher: List<dynamic>.from(json["subjectsTeacher"].map((x) => x)),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        schools: List<dynamic>.from(json["schools"].map((x) => x)),
        disclaimers: List<Disclaimer>.from(json["disclaimers"].map((x) => Disclaimer.fromJson(x))),
        expirationTokenTime: json["expirationTokenTime"],
        status: json["status"],
        acceptCommercialMessage: json["acceptCommercialMessage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lastName": lastName,
        "role": role,
        "nia": nia,
        "telephone": telephone,
        "avatar": avatar,
        "lastConnection": lastConnection,
        "firstName": firstName,
        "email": email,
        "dni": dni,
        "username": username,
        "accessToken": accessToken,
        "importCode": importCode,
        "degrees": List<dynamic>.from(degrees.map((x) => x)),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "subjectsTeacher": List<dynamic>.from(subjectsTeacher.map((x) => x)),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "schools": List<dynamic>.from(schools.map((x) => x)),
        "disclaimers": List<dynamic>.from(disclaimers.map((x) => x.toJson())),
        "expirationTokenTime": expirationTokenTime,
        "status": status,
        "acceptCommercialMessage": acceptCommercialMessage,
    };
}

class Disclaimer {
    String type;
    bool accepted;

    Disclaimer({
        this.type,
        this.accepted,
    });

    factory Disclaimer.fromJson(Map<String, dynamic> json) => Disclaimer(
        type: json["type"],
        accepted: json["accepted"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "accepted": accepted,
    };
}
