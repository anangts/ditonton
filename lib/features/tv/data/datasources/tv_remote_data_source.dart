import 'dart:convert';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/features/tv/data/models/models.dart';
import 'package:http/io_client.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final IOClient _client;
  TvRemoteDataSourceImpl(this._client);

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    // uncomment for check ssl_pinning
    // final response = await _client.get(
    //   Uri.parse('https://www.google.com/'),
    // );
    final response = await _client.get(
      Uri.parse('$baseUrl/tv/airing_today?$apiKey'),
    );
    return TvResponse.fromJson(json.decode(response.body)).tvList;
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/tv/$id?$apiKey'),
    );
    return TvDetailResponse.fromJson(json.decode(response.body));
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'),
    );
    return TvResponse.fromJson(json.decode(response.body)).tvList;
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/tv/popular?$apiKey'),
    );
    return TvResponse.fromJson(json.decode(response.body)).tvList;
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
    );
    return TvResponse.fromJson(json.decode(response.body)).tvList;
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
    );
    return TvResponse.fromJson(json.decode(response.body)).tvList;
  }
}
