import 'dart:convert';

import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/features/tv/data/datasources/tv_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ditonton/features/tv/data/models/models.dart';

import 'package:ditonton/common/api_config.dart';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:mockito/mockito.dart';

import '../../../movie/helpers/test_helper.mocks.dart';

void main() {
  group('TvRemoteDataSourceImpl', () {
    WidgetsFlutterBinding.ensureInitialized();
    late TvRemoteDataSourceImpl dataSource;
    late MockClient client;
    late SSLPinning sslPinning;

    setUp(() {
      client = MockClient();

      // Mock consistent API responses
      when(client.get(any)).thenAnswer((invocation) async {
        final request = invocation.positionalArguments[0];
        switch (request.url.toString()) {
          case '$baseUrl/tv/airing_today?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 1,
                    'title': 'Tv 1',
                    'overview': 'This is a tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 8.5,
                    'vote_count': 100,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/tv/popular?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 3,
                    'title': 'Tv 3',
                    'overview': 'This is a popular tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 9.0,
                    'vote_count': 200,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/tv/top_rated?$apiKey':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 5,
                    'title': 'Tv 5',
                    'overview': 'This is a top-rated tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 9.5,
                    'vote_count': 300,
                  },
                ],
              }),
              200,
            );
          case '$baseUrl/search/tv?$apiKey&query=hello':
            return http.Response(
              jsonEncode({
                'results': [
                  {
                    'id': 9,
                    'title': 'Tv 9',
                    'overview': 'This is a searched tv',
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
          TvRemoteDataSourceImpl(client: IOClient(), sslPinning: sslPinning);
    });
    test('getNowPlayingTv returns a list of tv', () async {
      final result = await dataSource.getNowPlayingTv();

      expect(result, isA<List<TvModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('getPopularTv returns a list of tv', () async {
      final result = await dataSource.getPopularTv();

      expect(result, isA<List<TvModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('getTopRated Tv returns a list of tv', () async {
      final result = await dataSource.getTopRatedTv();

      expect(result, isA<List<TvModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    });

    test('searchTv returns a list of tv', () async {
      final result = await dataSource.searchTv('hello');

      expect(result, isA<List<TvModel>>());
      expect(result.length, greaterThan(0));
      expect(result[0].id, isNotNull);
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
