import 'dart:convert';

import 'package:ditonton/features/tv/data/models/tv_model.dart';
import 'package:ditonton/features/tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../tv_json_reader.dart';

void main() {
  const tTvModel = TvModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    releaseDate: "2020-05-05",
    name: "name",
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );
  const tvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "name": "name",
            "video": false,
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
