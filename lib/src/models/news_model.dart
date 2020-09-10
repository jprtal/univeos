import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
        this.accessToken,
        this.news,
        this.pagination,
    });

    String accessToken;
    List<News> news;
    Pagination pagination;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        accessToken: json["accessToken"],
        news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "news": List<dynamic>.from(news.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
    };
}

class News {
    String category;
    int id;
    String imgDetail;
    String imgWidget;
    bool isFavouriteForUser;
    String newAuthor;
    String newDescription;
    int newFavorites;
    bool newIsFromUniversia;
    DateTime newPublicDate;
    int newShares;
    String newTitle;
    dynamic videoUrl;

    News({
        this.category,
        this.id,
        this.imgDetail,
        this.imgWidget,
        this.isFavouriteForUser,
        this.newAuthor,
        this.newDescription,
        this.newFavorites,
        this.newIsFromUniversia,
        this.newPublicDate,
        this.newShares,
        this.newTitle,
        this.videoUrl,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        category: json["category"],
        id: json["id"],
        imgDetail: json["imgDetail"],
        imgWidget: json["imgWidget"],
        isFavouriteForUser: json["isFavouriteForUser"],
        newAuthor: json["newAuthor"],
        newDescription: json["newDescription"],
        newFavorites: json["newFavorites"],
        newIsFromUniversia: json["newIsFromUniversia"],
        newPublicDate: DateTime.parse(json["newPublicDate"]),
        newShares: json["newShares"],
        newTitle: json["newTitle"],
        videoUrl: json["videoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "imgDetail": imgDetail,
        "imgWidget": imgWidget,
        "isFavouriteForUser": isFavouriteForUser,
        "newAuthor": newAuthor,
        "newDescription": newDescription,
        "newFavorites": newFavorites,
        "newIsFromUniversia": newIsFromUniversia,
        "newPublicDate": newPublicDate.toIso8601String(),
        "newShares": newShares,
        "newTitle": newTitle,
        "videoUrl": videoUrl,
    };
}

class Pagination {
    Pagination({
        this.currentPage,
        this.nextPage,
        this.prevPage,
        this.totalCount,
        this.totalPages,
    });

    int currentPage;
    int nextPage;
    int prevPage;
    int totalCount;
    int totalPages;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        prevPage: json["prevPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "nextPage": nextPage,
        "prevPage": prevPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
    };
}