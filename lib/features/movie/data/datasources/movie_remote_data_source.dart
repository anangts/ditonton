import 'dart:convert';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/features/movie/data/models/models.dart';
import 'package:http/io_client.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovie();
  Future<List<MovieModel>> getPopularMovie();
  Future<List<MovieModel>> getTopRatedMovie();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovie(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final IOClient _client;
  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    // final response = await _client.get(
    //   Uri.parse('https://www.google.com/'),
    // );
    final response = await _client.get(
      Uri.parse('$baseUrl/movie/now_playing?$apiKey'),
    );
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/movie/$id?$apiKey'),
    );
    return MovieDetailResponse.fromJson(json.decode(response.body));
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'),
    );
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/movie/popular?$apiKey'),
    );
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/movie/top_rated?$apiKey'),
    );
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'),
    );
    return MovieResponse.fromJson(json.decode(response.body)).movieList;
  }
}
