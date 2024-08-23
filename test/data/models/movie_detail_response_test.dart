import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/domain/entities/genre.dart';

import 'package:ditonton/domain/entities/movie_detail.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/data/models/genre_model.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: 'Action');
  const tGenre = Genre(id: 1, name: 'Action');
  const tMovieDetailResponse = MovieDetailResponse(
    adult: false,
    backdropPath: '/path.jpg',
    budget: 100000000,
    genres: [tGenreModel],
    homepage: 'https://homepage.com',
    id: 1,
    imdbId: 'tt1234567',
    originalLanguage: 'en',
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 100.0,
    posterPath: '/poster.jpg',
    releaseDate: '2021-09-17',
    revenue: 200000000,
    runtime: 120,
    status: 'Released',
    tagline: 'Tagline',
    title: 'Title',
    video: false,
    voteAverage: 8.0,
    voteCount: 1000,
  );

  group('MovieDetailResponse', () {
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
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 100.0,
        "poster_path": "/poster.jpg",
        "release_date": "2021-09-17",
        "revenue": 200000000,
        "runtime": 120,
        "status": "Released",
        "tagline": "Tagline",
        "title": "Title",
        "video": false,
        "vote_average": 8.0,
        "vote_count": 1000,
      };

      // act
      final result = MovieDetailResponse.fromJson(jsonMap);

      // assert
      expect(result, tMovieDetailResponse);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tMovieDetailResponse.toJson();

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
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 100.0,
        "poster_path": "/poster.jpg",
        "release_date": "2021-09-17",
        "revenue": 200000000,
        "runtime": 120,
        "status": "Released",
        "tagline": "Tagline",
        "title": "Title",
        "video": false,
        "vote_average": 8.0,
        "vote_count": 1000,
      };
      expect(result, expectedJsonMap);
    });

    test('should return a MovieDetail entity from MovieDetailResponse', () {
      // act
      final result = tMovieDetailResponse.toEntity();

      // assert
      const expectedEntity = MovieDetail(
        adult: false,
        backdropPath: '/path.jpg',
        genres: [tGenre],
        id: 1,
        originalTitle: 'Original Title',
        overview: 'Overview',
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        runtime: 120,
        title: 'Title',
        voteAverage: 8.0,
        voteCount: 1000,
      );
      expect(result, expectedEntity);
    });

    test('should return true when comparing two identical MovieDetailResponses',
        () {
      // arrange
      const movieDetailResponse1 = MovieDetailResponse(
        adult: false,
        backdropPath: '/path.jpg',
        budget: 100000000,
        genres: [tGenreModel],
        homepage: 'https://homepage.com',
        id: 1,
        imdbId: 'tt1234567',
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'Overview',
        popularity: 100.0,
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        revenue: 200000000,
        runtime: 120,
        status: 'Released',
        tagline: 'Tagline',
        title: 'Title',
        video: false,
        voteAverage: 8.0,
        voteCount: 1000,
      );
      const movieDetailResponse2 = MovieDetailResponse(
        adult: false,
        backdropPath: '/path.jpg',
        budget: 100000000,
        genres: [tGenreModel],
        homepage: 'https://homepage.com',
        id: 1,
        imdbId: 'tt1234567',
        originalLanguage: 'en',
        originalTitle: 'Original Title',
        overview: 'Overview',
        popularity: 100.0,
        posterPath: '/poster.jpg',
        releaseDate: '2021-09-17',
        revenue: 200000000,
        runtime: 120,
        status: 'Released',
        tagline: 'Tagline',
        title: 'Title',
        video: false,
        voteAverage: 8.0,
        voteCount: 1000,
      );

      // act & assert
      expect(movieDetailResponse1, movieDetailResponse2);
    });
  });
}
