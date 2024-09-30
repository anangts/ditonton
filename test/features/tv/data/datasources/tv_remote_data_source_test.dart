import 'dart:convert';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/features/tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/features/tv/data/models/tv_detail_model.dart';
import 'package:ditonton/features/tv/data/models/tv_model.dart';
import 'package:ditonton/features/tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'tv_remote_data_source_test.mocks.dart';

@GenerateMocks([IOClient])
void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(mockHttpClient);
  });

  group('getNowPlayingTv', () {
    final tTvList = [
      const TvModel(
        adult: false,
        backdropPath: "/path.jpg",
        genreIds: [12, 16, 35],
        id: 1,
        originalName: 'Spider-Man: No Way Home',
        overview: 'Peter Parker faces a challenge with the multiverse.',
        popularity: 100.0,
        posterPath: "/poster.jpg",
        releaseDate: "2021-12-17",
        name: 'Spider-Man: No Way Home',
        video: false,
        voteAverage: 8.5,
        voteCount: 2000,
      ),
    ];

    final tTvResponse = TvResponse(tvList: tTvList);

    test(
        'should return list of TvModel when the response code is 200 (success)',
        () async {
      // Arrange

      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tTvResponse.toJson()), 200));

      // Act
      final result = await dataSource.getNowPlayingTv();

      // Assert
      expect(result, tTvList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getNowPlayingTv();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
  group('getTvDetail', () {
    const tTvDetail = TvDetailResponse(
      adult: false,
      backdropPath: "/path.jpg",
      budget: 200000000,
      genres: [],
      homepage: 'https://spiderman.com',
      id: 1,
      imdbId: 'tt1234567',
      originalLanguage: 'en',
      originalName: 'Spider-Man: No Way Home',
      overview: 'Peter Parker faces a challenge with the multiverse.',
      popularity: 100.0,
      posterPath: "/poster.jpg",
      releaseDate: "2021-12-17",
      revenue: 1500000000,
      runtime: 120,
      status: 'Released',
      tagline: 'No one goes home.',
      name: 'Spider-Man: No Way Home',
      video: false,
      voteAverage: 8.5,
      voteCount: 2000,
    );

    const tTvId = 1;
    test('should return TvDetailResponse when the response code is 200',
        () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(json.encode(tTvDetail.toJson()), 200));

      // Act
      final result = await dataSource.getTvDetail(tTvId);

      // Assert
      expect(result, tTvDetail);
    });
  });

  group('getTvRecommendations', () {
    final tTvList = [
      const TvModel(
        adult: false,
        backdropPath: "/path.jpg",
        genreIds: [12, 16, 35],
        id: 2,
        originalName: 'Avengers: Endgame',
        overview: 'The Avengers take a final stand against Thanos.',
        popularity: 200.0,
        posterPath: "/avengers.jpg",
        releaseDate: "2019-04-26",
        name: 'Avengers: Endgame',
        video: false,
        voteAverage: 9.0,
        voteCount: 3000,
      ),
    ];

    final tTvResponse = TvResponse(tvList: tTvList);

    test(
        'should return list of TvModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/1/recommendations?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tTvResponse.toJson()), 200));

      // Act
      final result = await dataSource.getTvRecommendations(1);

      // Assert
      expect(result, tTvList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/1/recommendations?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getTvRecommendations(1);

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('getPopularTv', () {
    const tTvResponse = TvResponse(tvList: []);

    test(
        'should return list of TvModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tTvResponse.toJson()), 200));

      // Act
      final result = await dataSource.getPopularTv();

      // Assert
      expect(result, tTvResponse.tvList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getPopularTv();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('getTopRatedTv', () {
    const tTvResponse = TvResponse(tvList: []);

    test(
        'should return list of TvModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer(
              (_) async => Response(json.encode(tTvResponse.toJson()), 200));

      // Act
      final result = await dataSource.getTopRatedTv();

      // Assert
      expect(result, tTvResponse.tvList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.getTopRatedTv();

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('searchTv', () {
    const tTvResponse = TvResponse(tvList: []);

    test(
        'should return list of TvModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=spiderman')))
          .thenAnswer(
              (_) async => Response(json.encode(tTvResponse.toJson()), 200));

      // Act
      final result = await dataSource.searchTv('spiderman');

      // Assert
      expect(result, tTvResponse.tvList);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // Arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=spiderman')))
          .thenAnswer((_) async => Response('Something went wrong', 404));

      // Act
      final call = dataSource.searchTv('spiderman');

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}
