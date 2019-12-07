// To parse this JSON data, do
//
//     final tuiModel = tuiModelFromJson(jsonString);

import 'dart:convert';

TuiModel tuiModelFromJson(String str) => TuiModel.fromJson(json.decode(str));

String tuiModelToJson(TuiModel data) => json.encode(data.toJson());

class TuiModel {
    String codeType;
    Render render;
    DateTime renewal;
    String roleDescription;
    String status;

    TuiModel({
        this.codeType,
        this.render,
        this.renewal,
        this.roleDescription,
        this.status,
    });

    factory TuiModel.fromJson(Map<String, dynamic> json) => TuiModel(
        codeType: json["codeType"],
        render: Render.fromJson(json["render"]),
        renewal: DateTime.parse(json["renewal"]),
        roleDescription: json["roleDescription"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "codeType": codeType,
        "render": render.toJson(),
        "renewal": renewal.toIso8601String(),
        "roleDescription": roleDescription,
        "status": status,
    };
}

class Render {
    String back;
    Barcode barcode;
    String front;
    String fullname;
    String line1;
    dynamic line2;
    dynamic line3;
    dynamic pan;
    String photo;
    Qrcode qrcode;

    Render({
        this.back,
        this.barcode,
        this.front,
        this.fullname,
        this.line1,
        this.line2,
        this.line3,
        this.pan,
        this.photo,
        this.qrcode,
    });

    factory Render.fromJson(Map<String, dynamic> json) => Render(
        back: json["back"],
        barcode: Barcode.fromJson(json["barcode"]),
        front: json["front"],
        fullname: json["fullname"],
        line1: json["line1"],
        line2: json["line2"],
        line3: json["line3"],
        pan: json["pan"],
        photo: json["photo"],
        qrcode: Qrcode.fromJson(json["qrcode"]),
    );

    Map<String, dynamic> toJson() => {
        "back": back,
        "barcode": barcode.toJson(),
        "front": front,
        "fullname": fullname,
        "line1": line1,
        "line2": line2,
        "line3": line3,
        "pan": pan,
        "photo": photo,
        "qrcode": qrcode.toJson(),
    };
}

class Barcode {
    String type;
    String value;

    Barcode({
        this.type,
        this.value,
    });

    factory Barcode.fromJson(Map<String, dynamic> json) => Barcode(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}

class Qrcode {
    String value;

    Qrcode({
        this.value,
    });

    factory Qrcode.fromJson(Map<String, dynamic> json) => Qrcode(
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
    };
}
