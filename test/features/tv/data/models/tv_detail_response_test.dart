import 'package:ditonton/features/tv/data/models/tv_detail_model.dart';
import 'package:ditonton/features/tv/data/models/tv_genre_model.dart';

import 'package:ditonton/features/tv/domain/entities/tv_detail.dart';
import 'package:ditonton/features/tv/domain/entities/tvgenre.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = TvGenreModel(id: 1, name: 'Action');
  const tGenre = TvGenre(id: 1, name: 'Action');
  const tTvDetailResponse = TvDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    budget: 100000000,
    genres: [tGenreModel],
    homepage: 'https://homepage.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 100.0,
    posterPath: '/poster.jpg',
    releaseDate: '2021-09-17',
    revenue: 200000000,
    runtime: 120,
    status: 'Released',
    tagline: 'Tagline',
    name: 'name',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  group('TvDetailResponse', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "budget": 100000000,
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "homepage": "https://homepage.com",
        "id": 1,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_name": "Original Name",
        "overview": "Overview",
        "popularity": 100.0,
        "poster_path": "/poster.jpg",
        "release_date": "2021-09-17",
        "revenue": 200000000,
        "runtime": 120,
        "status": "Released",
        "tagline": "Tagline",
        "name": "name",
        "video": false,
        "vote_average": 8.0,
        "vote_count": 1000,
      };

      // act
      final result = TvDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, tTvDetailResponse);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tTvDetailResponse.toJson();

      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "budget": 100000000,
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "homepage": "https://homepage.com",
        "id": 1,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_name": "Original Name",
        "overview": "Overview",
        "popularity": 100.0,
        "poster_path": "/poster.jpg",
        "release_date": "2021-09-17",
        "revenue": 200000000,
        "runtime": 120,
        "status": "Released",
        "tagline": "Tagline",
        "name": "name",
        "video": false,
        "vote_average": 8.0,
        "vote_count": 1000,
      };
      expect(result, expectedJsonMap);
    });

    //editeds
    test('should return a TvDetail entity from TvDetailResponse', () {
      // act
      final result = tTvDetailResponse.toEntity();

      // assert
      const expectedEntity = TvDetail(
        adult: false,
        backdropPath: '/path.jpg',
        genres: [tGenre],
        id: 1,
        originalName: 'Original Name',
        overview: 'Overview',
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        runtime: 120,
        name: 'name',
        voteAverage: 8.0,
        voteCount: 1000,
      );
      expect(result, expectedEntity);
    });

    test('should return true when comparing two identical TvDetailResponses',
        () {
      // arrange
      const tvDetailResponse1 = TvDetailResponse(
        adult: false,
        backdropPath: '/path.jpg',
        budget: 100000000,
        genres: [tGenreModel],
        homepage: 'https://homepage.com',
        id: 1,
        imdbId: 'tt1234567',
        originalLanguage: 'en',
        originalName: 'Original Name',
        overview: 'Overview',
        popularity: 100.0,
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        revenue: 200000000,
        runtime: 120,
        status: 'Released',
        tagline: 'Tagline',
        name: 'name',
        video: false,
        voteAverage: 8.0,
        voteCount: 1000,
      );
      const tvDetailResponse2 = TvDetailResponse(
        adult: false,
        backdropPath: '/path.jpg',
        budget: 100000000,
        genres: [tGenreModel],
        homepage: 'https://homepage.com',
        id: 1,
        imdbId: 'tt1234567',
        originalLanguage: 'en',
        originalName: 'Original Name',
        overview: 'Overview',
        popularity: 100.0,
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        revenue: 200000000,
        runtime: 120,
        status: 'Released',
        tagline: 'Tagline',
        name: 'name',
        video: false,
        voteAverage: 8.0,
        voteCount: 1000,
      );

      // act & assert
      expect(tvDetailResponse1, tvDetailResponse2);
    });
  });
}
