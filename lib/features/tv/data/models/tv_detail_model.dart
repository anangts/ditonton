import 'package:ditonton/features/tv/data/models/tv_genre_model.dart';
import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.name,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final int? budget;
  final List<TvGenreModel> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String? originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final String status;
  final String tagline;
  final String? name;
  final bool? video;
  final double voteAverage;
  final int voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genres: List<TvGenreModel>.from(
            json["genres"].map((x) => TvGenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "revenue": revenue,
        "runtime": runtime,
        "status": status,
        "tagline": tagline,
        "name": name,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      adult: adult,
      backdropPath: backdropPath,
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      name: name,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        releaseDate,
        revenue,
        runtime,
        status,
        tagline,
        name,
        video,
        voteAverage,
        voteCount,
      ];
}
