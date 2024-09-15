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
                  {
                    'id': 2,
                    'title': 'Tv 2',
                    'overview': 'This is another tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 7.5,
                    'vote_count': 50,
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
                  {
                    'id': 4,
                    'title': 'Tv 4',
                    'overview': 'This is another popular tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 8.0,
                    'vote_count': 150,
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
                  {
                    'id': 6,
                    'title': 'Tv 6',
                    'overview': 'This is another top-rated tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 9.0,
                    'vote_count': 250,
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
                  {
                    'id': 10,
                    'title': 'Tv 10',
                    'overview': 'This is another searched tv',
                    'poster_path': '/path/to/poster',
                    'release_date': '2022-01-01',
                    'vote_average': 8.0,
                    'vote_count': 50,
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

      expect(result.length, 20);

      expect(result[0].id, 224);
      expect(result[0].name, 'Match of the Day');
    });

    test('getPopularTv returns a list of tv', () async {
      final result = await dataSource.getPopularTv();

      expect(result, isA<List<TvModel>>());

      expect(result.length, 19);

      expect(result[0].id, 224);

      expect(result[0].name, 'Match of the Day');
    });

    test('getTopRated Tv returns a list of tv', () async {
      final result = await dataSource.getTopRatedTv();

      expect(result, isA<List<TvModel>>());

      expect(result.length, 20);

      expect(result[0].id, 1396);

      expect(result[0].name, 'Breaking Bad');
    });

    test('searchTv returns a list of tv', () async {
      final result = await dataSource.searchTv('hello');

      expect(result, isA<List<TvModel>>());

      expect(result.length, 19);

      expect(result[0].id, 154770);

      expect(result[0].name, 'Hello Saturday');
    });
  });
}
