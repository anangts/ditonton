import 'dart:convert';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movie/data/models/movie_detail_model.dart';
import 'package:ditonton/features/movie/data/models/movie_model.dart';
import 'package:ditonton/features/movie/data/models/movie_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([IOClient])
void main() {
  late MovieRemoteDataSourceImpl dataSource;
  late MockIOClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockIOClient();
    dataSource = MovieRemoteDataSourceImpl(mockHttpClient);
  });

  group('getNowPlayingMovie', () {
    final tMovieList = [
      const MovieModel(
        adult: false,
        backdropPath: "/path.jpg",
        genreIds: [12, 16, 35],
        id: 1,
        originalTitle: 'Spider-Man: No Way Home',
        overview: 'Peter Parker faces a challenge with the multiverse.',
        popularity: 100.0,
        posterPath: "/poster.jpg",
        releaseDate: "2021-12-17",
        title: 'Spider-Man: No Way Home',
        video: false,
        voteAverage: 8.5,
        voteCount: 2000,
      ),
    ];

    final tMovieResponse = MovieResponse(movieList: tMovieList);

    test(
        'should return list of MovieModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tMovieResponse.toJson()), 200));

      // Act
      final result = await dataSource.getNowPlayingMovie();

      // Assert
      expect(result, tMovieList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getNowPlayingMovie();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
  group('getMovieDetail', () {
    const tMovieDetail = MovieDetailResponse(
      adult: false,
      backdropPath: "/path.jpg",
      budget: 200000000,
      genres: [],
      homepage: 'https://spiderman.com',
      id: 1,
      imdbId: 'tt1234567',
      originalLanguage: 'en',
      originalTitle: 'Spider-Man: No Way Home',
      overview: 'Peter Parker faces a challenge with the multiverse.',
      popularity: 100.0,
      posterPath: "/poster.jpg",
      releaseDate: "2021-12-17",
      revenue: 1500000000,
      runtime: 120,
      status: 'Released',
      tagline: 'No one goes home.',
      title: 'Spider-Man: No Way Home',
      video: false,
      voteAverage: 8.5,
      voteCount: 2000,
    );

    const tMovieId = 1;
    test('should return MovieDetailResponse when the response code is 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(tMovieDetail.toJson()), 200));

      // Act
      final result = await dataSource.getMovieDetail(tMovieId);

      // Assert
      expect(result, tMovieDetail);
    });
  });

  group('getMovieRecommendations', () {
    final tMovieList = [
      const MovieModel(
        adult: false,
        backdropPath: "/path.jpg",
        genreIds: [12, 16, 35],
        id: 2,
        originalTitle: 'Avengers: Endgame',
        overview: 'The Avengers take a final stand against Thanos.',
        popularity: 200.0,
        posterPath: "/avengers.jpg",
        releaseDate: "2019-04-26",
        title: 'Avengers: Endgame',
        video: false,
        voteAverage: 9.0,
        voteCount: 3000,
      ),
    ];

    final tMovieResponse = MovieResponse(movieList: tMovieList);

    test(
        'should return list of MovieModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/movie/1/recommendations?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tMovieResponse.toJson()), 200));

      // Act
      final result = await dataSource.getMovieRecommendations(1);

      // Assert
      expect(result, tMovieList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/movie/1/recommendations?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getMovieRecommendations(1);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('getPopularMovie', () {
    const tMovieResponse = MovieResponse(movieList: []);

    test(
        'should return list of MovieModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tMovieResponse.toJson()), 200));

      // Act
      final result = await dataSource.getPopularMovie();

      // Assert
      expect(result, tMovieResponse.movieList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getPopularMovie();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('getTopRatedMovie', () {
    const tMovieResponse = MovieResponse(movieList: []);

    test(
        'should return list of MovieModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tMovieResponse.toJson()), 200));

      // Act
      final result = await dataSource.getTopRatedMovie();

      // Assert
      expect(result, tMovieResponse.movieList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getTopRatedMovie();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('searchMovie', () {
    const tMovieResponse = MovieResponse(movieList: []);

    test(
        'should return list of MovieModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=spiderman')))
          .thenAnswer(
              (_) async => Response(json.encode(tMovieResponse.toJson()), 200));

      // Act
      final result = await dataSource.searchMovie('spiderman');

      // Assert
      expect(result, tMovieResponse.movieList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=spiderman')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.searchMovie('spiderman');

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}
