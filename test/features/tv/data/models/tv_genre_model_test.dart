import 'package:ditonton/features/tv/data/models/tv_genre_model.dart';
import 'package:ditonton/features/tv/domain/entities/tvgenre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = TvGenreModel(
    id: 1,
    name: 'Action',
  );

  group('GenreModel', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "Action",
      };

      // act
      final result = TvGenreModel.fromJson(jsonMap);

      // assert
      expect(result, tGenreModel);
    });

    test('should return a JSON map containing proper data', () {
      // act
      final result = tGenreModel.toJson();

      // assert
      final expectedJsonMap = {
        "id": 1,
        "name": "Action",
      };
      expect(result, expectedJsonMap);
    });

    test('should return a Genre entity from GenreModel', () {
      // act
      final result = tGenreModel.toEntity();

      // assert
      const expectedEntity = TvGenre(id: 1, name: 'Action');
      expect(result, expectedEntity);
    });

    test('should return true when comparing two identical GenreModels', () {
      // arrange
      const genreModel1 = TvGenreModel(id: 1, name: 'Action');
      const genreModel2 = TvGenreModel(id: 1, name: 'Action');

      // act & assert
      expect(genreModel1, genreModel2);
    });
  });
}
