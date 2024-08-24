// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  // Constructor utama
  Tv({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.name,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  // Constructor watchlist
  Tv.watchlist({
    required this.id,
    this.overview,
    this.posterPath,
    this.name,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? name;
  bool? video;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        releaseDate,
        name,
        video,
        voteAverage,
        voteCount,
      ];
}
