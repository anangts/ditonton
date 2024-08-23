// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  // Constructor utama
  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  // Constructor watchlist
  Movie.watchlist({
    required this.id,
    this.overview,
    this.posterPath,
    this.title,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
