// To parse this JSON data, do
//
//     final homeInfo = homeInfoFromJson(jsonString);

import 'dart:convert';

HomeInfoModel homeInfoFromJson(String str) => HomeInfoModel.fromJson(json.decode(str));

String homeInfoToJson(HomeInfoModel data) => json.encode(data.toJson());

class HomeInfoModel {
    String date;
    List<ActionButton> actionButtons;
    List<ActionButton> secondaryOptions;
    Widgets widgets;
    String accessToken;
    bool hasPendingNotifications;

    HomeInfoModel({
        this.date,
        this.actionButtons,
        this.secondaryOptions,
        this.widgets,
        this.accessToken,
        this.hasPendingNotifications,
    });

    factory HomeInfoModel.fromJson(Map<String, dynamic> json) => HomeInfoModel(
        date: json["date"],
        actionButtons: List<ActionButton>.from(json["actionButtons"].map((x) => ActionButton.fromJson(x))),
        secondaryOptions: List<ActionButton>.from(json["secondaryOptions"].map((x) => ActionButton.fromJson(x))),
        widgets: Widgets.fromJson(json["widgets"]),
        accessToken: json["accessToken"],
        hasPendingNotifications: json["hasPendingNotifications"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "actionButtons": List<dynamic>.from(actionButtons.map((x) => x.toJson())),
        "secondaryOptions": List<dynamic>.from(secondaryOptions.map((x) => x.toJson())),
        "widgets": widgets.toJson(),
        "accessToken": accessToken,
        "hasPendingNotifications": hasPendingNotifications,
    };
}

class ActionButton {
    String title;
    String icon;
    String url;
    dynamic package;
    dynamic iosPackage;
    String method;
    dynamic params;
    dynamic cookie;
    String keyName;
    String destinyType;

    ActionButton({
        this.title,
        this.icon,
        this.url,
        this.package,
        this.iosPackage,
        this.method,
        this.params,
        this.cookie,
        this.keyName,
        this.destinyType,
    });

    factory ActionButton.fromJson(Map<String, dynamic> json) => ActionButton(
        title: json["title"],
        icon: json["icon"] == null ? null : json["icon"],
        url: json["url"] == null ? null : json["url"],
        package: json["package"],
        iosPackage: json["iosPackage"],
        method: json["method"] == null ? null : json["method"],
        params: json["params"],
        cookie: json["cookie"],
        keyName: json["keyName"],
        destinyType: json["destinyType"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon == null ? null : icon,
        "url": url == null ? null : url,
        "package": package,
        "iosPackage": iosPackage,
        "method": method == null ? null : method,
        "params": params,
        "cookie": cookie,
        "keyName": keyName,
        "destinyType": destinyType,
    };
}

class Widgets {
    List<dynamic> highlighted;
    List<Sortable> sortables;
    List<dynamic> footer;

    Widgets({
        this.highlighted,
        this.sortables,
        this.footer,
    });

    factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
        highlighted: List<dynamic>.from(json["highlighted"].map((x) => x)),
        sortables: List<Sortable>.from(json["sortables"].map((x) => Sortable.fromJson(x))),
        footer: List<dynamic>.from(json["footer"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "highlighted": List<dynamic>.from(highlighted.map((x) => x)),
        "sortables": List<dynamic>.from(sortables.map((x) => x.toJson())),
        "footer": List<dynamic>.from(footer.map((x) => x)),
    };
}

class Sortable {
    String title;
    String icon;
    String url;
    dynamic package;
    dynamic iosPackage;
    String method;
    dynamic params;
    dynamic cookie;
    String keyName;
    String destinyType;
    bool isLoaded;
    bool isHideable;
    int id;
    dynamic widgetDescription;
    String layoutType;
    String image;

    Sortable({
        this.title,
        this.icon,
        this.url,
        this.package,
        this.iosPackage,
        this.method,
        this.params,
        this.cookie,
        this.keyName,
        this.destinyType,
        this.isLoaded,
        this.isHideable,
        this.id,
        this.widgetDescription,
        this.layoutType,
        this.image,
    });

    factory Sortable.fromJson(Map<String, dynamic> json) => Sortable(
        title: json["title"],
        icon: json["icon"],
        url: json["url"],
        package: json["package"],
        iosPackage: json["iosPackage"],
        method: json["method"],
        params: json["params"],
        cookie: json["cookie"],
        keyName: json["keyName"],
        destinyType: json["destinyType"],
        isLoaded: json["isLoaded"],
        isHideable: json["isHideable"],
        id: json["id"],
        widgetDescription: json["widgetDescription"],
        layoutType: json["layoutType"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "icon": icon,
        "url": url,
        "package": package,
        "iosPackage": iosPackage,
        "method": method,
        "params": params,
        "cookie": cookie,
        "keyName": keyName,
        "destinyType": destinyType,
        "isLoaded": isLoaded,
        "isHideable": isHideable,
        "id": id,
        "widgetDescription": widgetDescription,
        "layoutType": layoutType,
        "image": image == null ? null : image,
    };
}
