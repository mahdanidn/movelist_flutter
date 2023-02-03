// To parse this JSON data, do
//
//     final movieListModel = movieListModelFromJson(jsonString);

import 'dart:convert';

MovieListModel movieListModelFromJson(String str) =>
    MovieListModel.fromJson(json.decode(str));

String movieListModelToJson(MovieListModel data) => json.encode(data.toJson());

class MovieListModel {
  MovieListModel({
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.title,
  });

  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? title;

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
      };
}
