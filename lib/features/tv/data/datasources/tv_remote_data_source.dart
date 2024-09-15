// import 'dart:convert';
// import 'dart:io';
// import 'package:ditonton/common/api_config.dart';
// import 'package:ditonton/features/tv/data/models/tv_detail_model.dart';
// import 'package:ditonton/features/tv/data/models/tv_model.dart';
// import 'package:ditonton/features/tv/data/models/tv_response.dart';
// import 'package:ditonton/common/exception.dart';
// import 'package:http/io_client.dart';
// import 'package:flutter/services.dart';

// abstract class TvRemoteDataSource {
//   Future<List<TvModel>> getNowPlayingTv();
//   Future<List<TvModel>> getPopularTv();
//   Future<List<TvModel>> getTopRatedTv();
//   Future<TvDetailResponse> getTvDetail(int id);
//   Future<List<TvModel>> getTvRecommendations(int id);
//   Future<List<TvModel>> searchTv(String query);
// }

// class TvRemoteDataSourceImpl implements TvRemoteDataSource {
//   final IOClient client;

//   TvRemoteDataSourceImpl({required this.client});
//   Future<SecurityContext> get globalContext async {
//     final sslCert = await rootBundle.load('assets/certs/thetvdb-org.pem');
//     SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
//     securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
//     return securityContext;
//   }

//   @override
//   Future<List<TvModel>> getNowPlayingTv() async {
//     HttpClient client = HttpClient(context: await globalContext);
//     client.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => false;
//     IOClient ioClient = IOClient(client);
//     //uncomment to check ssl-pinning
//     //final response = await ioClient.get(Uri.parse('https://www.google.com/'));
//     final response =
//         await ioClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));
//     if (response.statusCode == 200) {
//       return TvResponse.fromJson(json.decode(response.body)).tvList;
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<TvDetailResponse> getTvDetail(int id) async {
//     final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

//     if (response.statusCode == 200) {
//       return TvDetailResponse.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<List<TvModel>> getTvRecommendations(int id) async {
//     final response =
//         await client.get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

//     if (response.statusCode == 200) {
//       return TvResponse.fromJson(json.decode(response.body)).tvList;
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<List<TvModel>> getPopularTv() async {
//     final response = await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));

//     if (response.statusCode == 200) {
//       return TvResponse.fromJson(json.decode(response.body)).tvList;
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<List<TvModel>> getTopRatedTv() async {
//     final response =
//         await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));

//     if (response.statusCode == 200) {
//       return TvResponse.fromJson(json.decode(response.body)).tvList;
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<List<TvModel>> searchTv(String query) async {
//     final response =
//         await client.get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));

//     if (response.statusCode == 200) {
//       return TvResponse.fromJson(json.decode(response.body)).tvList;
//     } else {
//       throw ServerException();
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:ditonton/common/api_config.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/ssl_pinning.dart';
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
  final SSLPinning sslPinning;
  final IOClient client;

  TvRemoteDataSourceImpl({required this.sslPinning, required this.client});

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    // uncomment this to check SSL Pinning Security
    //final response = await _getResponse('https://www.google.com/');
    final response = await _getResponse('$baseUrl/tv/airing_today?$apiKey');
    return TvResponse.fromJson(json.decode(response)).tvList;
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await _getResponse('$baseUrl/tv/$id?$apiKey');
    return TvDetailResponse.fromJson(json.decode(response));
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response =
        await _getResponse('$baseUrl/tv/$id/recommendations?$apiKey');
    return TvResponse.fromJson(json.decode(response)).tvList;
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await _getResponse('$baseUrl/tv/popular?$apiKey');
    return TvResponse.fromJson(json.decode(response)).tvList;
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response = await _getResponse('$baseUrl/tv/top_rated?$apiKey');
    return TvResponse.fromJson(json.decode(response)).tvList;
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    final response =
        await _getResponse('$baseUrl/search/tv?$apiKey&query=$query');
    return TvResponse.fromJson(json.decode(response)).tvList;
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
