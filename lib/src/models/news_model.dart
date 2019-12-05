// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    String accessToken;
    List<News> news;
    Pagination pagination;

    NewsModel({
        this.accessToken,
        this.news,
        this.pagination,
    });

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
    bool isFavouriteForUser;
    String newAuthor;
    String newDescription;
    int newFavorites;
    String newImage;
    bool newIsFromUniversia;
    DateTime newPublicDate;
    int newShares;
    String newTitle;
    dynamic videoUrl;

    News({
        this.category,
        this.id,
        this.isFavouriteForUser,
        this.newAuthor,
        this.newDescription,
        this.newFavorites,
        this.newImage,
        this.newIsFromUniversia,
        this.newPublicDate,
        this.newShares,
        this.newTitle,
        this.videoUrl,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        category: json["category"],
        id: json["id"],
        isFavouriteForUser: json["isFavouriteForUser"],
        newAuthor: json["newAuthor"],
        newDescription: json["newDescription"],
        newFavorites: json["newFavorites"],
        newImage: json["newImage"],
        newIsFromUniversia: json["newIsFromUniversia"],
        newPublicDate: DateTime.parse(json["newPublicDate"]),
        newShares: json["newShares"],
        newTitle: json["newTitle"],
        videoUrl: json["videoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "isFavouriteForUser": isFavouriteForUser,
        "newAuthor": newAuthor,
        "newDescription": newDescription,
        "newFavorites": newFavorites,
        "newImage": newImage,
        "newIsFromUniversia": newIsFromUniversia,
        "newPublicDate": newPublicDate.toIso8601String(),
        "newShares": newShares,
        "newTitle": newTitle,
        "videoUrl": videoUrl,
    };
}

class Pagination {
    int currentPage;
    int nextPage;
    dynamic prevPage;
    int totalCount;
    int totalPages;

    Pagination({
        this.currentPage,
        this.nextPage,
        this.prevPage,
        this.totalCount,
        this.totalPages,
    });

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
