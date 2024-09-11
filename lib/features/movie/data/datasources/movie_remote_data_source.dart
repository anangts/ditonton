import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/features/movie/data/models/movie_detail_model.dart';
import 'package:ditonton/features/movie/data/models/movie_model.dart';
import 'package:ditonton/features/movie/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovie();
  Future<List<MovieModel>> getPopularMovie();
  Future<List<MovieModel>> getTopRatedMovie();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovie(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final IOClient client;

  MovieRemoteDataSourceImpl({required this.client});
  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('assets/certs/themoviedb-org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    //uncomment to check ssl-pinning
    // final response = await ioClient.get(Uri.parse('https://www.google.com/'));
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
    final response = await client.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
