import 'dart:convert';

import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ditonton/features/movie/data/models/models.dart';

import 'package:ditonton/common/api_config.dart';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:mockito/mockito.dart';

import '../../../movie/helpers/test_helper.mocks.dart';

void main() {
  group('MovieRemoteDataSourceImpl', () {
    WidgetsFlutterBinding.ensureInitialized();
    late MovieRemoteDataSourceImpl dataSource;
    late MockClient client;
    late SSLPinning sslPinning;

    setUp(() {
      client = MockClient();

      // Mock consistent API responses
      when(client.get(any)).thenAnswer((invocation) async {
        final request = invocation.positionalArguments[0];
        switch (request.url.toString()) {
          case '$baseUrl/movie/now_playing?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 1,
                    'title': 'Movie 1',
                    'overview': 'This is a movie',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 8.5,
                    'vote_count': 100,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/movie/popular?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 3,
                    'title': 'Movie 3',
                    'overview': 'This is a popular movie',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 9.0,
                    'vote_count': 200,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/movie/top_rated?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 5,
                    'title': 'Movie 5',
                    'overview': 'This is a top-rated movie',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 9.5,
                    'vote_count': 300,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/search/movie?$apiKey&query=hello':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 9,
                    'title': 'Movie 9',
                    'overview': 'This is a searched movie',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 8.5,
                    'vote_count': 100,
                  },
                ],
              }),
              200,
            );
          default:
            return http.Response('Not found', 404);
        }
      });

      sslPinning = SSLPinning();
      dataSource =
          MovieRemoteDataSourceImpl(client: IOClient(), sslPinning: sslPinning);
    });
    test('getNowPlayingMovie returns a list of movie', () async {
      final result = await dataSource.getNowPlayingMovie();

      expect(result, isA<List<MovieModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('getPopularMovie returns a list of movie', () async {
      final result = await dataSource.getPopularMovie();

      expect(result, isA<List<MovieModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('getTopRated Movie returns a list of movie', () async {
      final result = await dataSource.getTopRatedMovie();

      expect(result, isA<List<MovieModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('searchMovie returns a list of movie', () async {
      final result = await dataSource.searchMovie('hello');

      expect(result, isA<List<MovieModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
