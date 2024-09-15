import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/ssl_pinning.dart';
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
  final SSLPinning sslPinning;
  final IOClient client;

  MovieRemoteDataSourceImpl({required this.sslPinning, required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    // uncomment this to check SSL Pinning Security
    //final response = await _getResponse('https://www.google.com/');
    final response = await _getResponse('$baseUrl/movie/now_playing?$apiKey');
    return MovieResponse.fromJson(json.decode(response)).movieList;
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await _getResponse('$baseUrl/movie/$id?$apiKey');
    return MovieDetailResponse.fromJson(json.decode(response));
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response =
        await _getResponse('$baseUrl/movie/$id/recommendations?$apiKey');
    return MovieResponse.fromJson(json.decode(response)).movieList;
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await _getResponse('$baseUrl/movie/popular?$apiKey');
    return MovieResponse.fromJson(json.decode(response)).movieList;
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final response = await _getResponse('$baseUrl/movie/top_rated?$apiKey');
    return MovieResponse.fromJson(json.decode(response)).movieList;
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    final response =
        await _getResponse('$baseUrl/search/movie?$apiKey&query=$query');
    return MovieResponse.fromJson(json.decode(response)).movieList;
  }

  Future<String> _getResponse(String url) async {
    HttpClient httpClient = HttpClient(context: await SSLPinning.sslContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    IOClient ioClient = IOClient(httpClient);

    try {
      final response = await ioClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException();
      }
    } finally {
      ioClient.close();
    }
  }
}
