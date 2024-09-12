import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/features/movie/data/models/movie_detail_model.dart';
import 'package:ditonton/features/movie/data/models/movie_model.dart';
import 'package:ditonton/features/movie/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
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

  MovieRemoteDataSourceImpl({required this.sslPinning});

  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));
    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
    final response = await ioClient
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
    final response =
        await ioClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    HttpClient client = HttpClient(context: await sslPinning.sslContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
    final response = await ioClient
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
