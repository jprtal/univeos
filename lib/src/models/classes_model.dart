// To parse this JSON data, do
//
//     final classesModel = classesModelFromJson(jsonString);

import 'dart:convert';

ClassesModel classesModelFromJson(String str) => ClassesModel.fromJson(json.decode(str));

String classesModelToJson(ClassesModel data) => json.encode(data.toJson());

class ClassesModel {
    String accessToken;
    dynamic headerImage;
    List<Subject> subjects;
    List<dynamic> subjectsTeacher;
    List<ClassWidget> widgets;

    ClassesModel({
        this.accessToken,
        this.headerImage,
        this.subjects,
        this.subjectsTeacher,
        this.widgets,
    });

    factory ClassesModel.fromJson(Map<String, dynamic> json) => ClassesModel(
        accessToken: json["accessToken"],
        headerImage: json["headerImage"],
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
        subjectsTeacher: List<dynamic>.from(json["subjectsTeacher"].map((x) => x)),
        widgets: List<ClassWidget>.from(json["widgets"].map((x) => ClassWidget.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "headerImage": headerImage,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "subjectsTeacher": List<dynamic>.from(subjectsTeacher.map((x) => x)),
        "widgets": List<dynamic>.from(widgets.map((x) => x.toJson())),
    };
}

class Subject {
    DateTime createdAt;
    dynamic credits;
    int degreeId;
    dynamic description;
    String groupName;
    int id;
    String importCode;
    String name;
    dynamic professor;
    dynamic semester;
    String subjectUrl;
    dynamic theoreticalCredits;
    dynamic trainingCredits;
    DateTime updatedAt;

    Subject({
        this.createdAt,
        this.credits,
        this.degreeId,
        this.description,
        this.groupName,
        this.id,
        this.importCode,
        this.name,
        this.professor,
        this.semester,
        this.subjectUrl,
        this.theoreticalCredits,
        this.trainingCredits,
        this.updatedAt,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        createdAt: DateTime.parse(json["createdAt"]),
        credits: json["credits"],
        degreeId: json["degreeId"],
        description: json["description"],
        groupName: json["groupName"],
        id: json["id"],
        importCode: json["importCode"],
        name: json["name"],
        professor: json["professor"],
        semester: json["semester"],
        subjectUrl: json["subjectUrl"],
        theoreticalCredits: json["theoreticalCredits"],
        trainingCredits: json["trainingCredits"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "credits": credits,
        "degreeId": degreeId,
        "description": description,
        "groupName": groupName,
        "id": id,
        "importCode": importCode,
        "name": name,
        "professor": professor,
        "semester": semester,
        "subjectUrl": subjectUrl,
        "theoreticalCredits": theoreticalCredits,
        "trainingCredits": trainingCredits,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class ClassWidget {
    dynamic cookie;
    String destinyType;
    String icon;
    int id;
    dynamic image;
    dynamic iosPackage;
    String keyName;
    String method;
    dynamic package;
    dynamic params;
    String title;
    String url;
    dynamic widgetDescription;

    ClassWidget({
        this.cookie,
        this.destinyType,
        this.icon,
        this.id,
        this.image,
        this.iosPackage,
        this.keyName,
        this.method,
        this.package,
        this.params,
        this.title,
        this.url,
        this.widgetDescription,
    });

    factory ClassWidget.fromJson(Map<String, dynamic> json) => ClassWidget(
        cookie: json["cookie"],
        destinyType: json["destinyType"],
        icon: json["icon"],
        id: json["id"],
        image: json["image"],
        iosPackage: json["iosPackage"],
        keyName: json["keyName"],
        method: json["method"],
        package: json["package"],
        params: json["params"],
        title: json["title"],
        url: json["url"],
        widgetDescription: json["widgetDescription"],
    );

    Map<String, dynamic> toJson() => {
        "cookie": cookie,
        "destinyType": destinyType,
        "icon": icon,
        "id": id,
        "image": image,
        "iosPackage": iosPackage,
        "keyName": keyName,
        "method": method,
        "package": package,
        "params": params,
        "title": title,
        "url": url,
        "widgetDescription": widgetDescription,
    };
}