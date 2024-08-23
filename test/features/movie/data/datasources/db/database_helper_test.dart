// import 'package:ditonton/data/models/movie_table.dart';
// import 'package:ditonton/data/datasources/db/database_helper.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// void main() {
//   late DatabaseHelper databaseHelper;

//   setUpAll(() {
//     // Initialize sqflite ffi
//     sqfliteFfiInit();
//     databaseFactory = databaseFactoryFfi;
//   });

//   setUp(() async {
//     databaseHelper = DatabaseHelper();
//     final db = await databaseHelper.database;

//     // Clear the watchlist table before each test
//     await db!.execute('DELETE FROM watchlist');
//   });

//   test('Insert watchlist movie', () async {
//     // Arrange
//     const movie = MovieTable(
//       id: 1,
//       title: 'Movie Title',
//       posterPath: 'assets/circle-g.png',
//       overview: 'Movie Overview',
//     );

//     // Act
//     final result = await databaseHelper.insertWatchlist(movie);

//     // Assert
//     expect(result, 1); // The result should be the ID of the inserted row
//   });

//   test('Remove watchlist movie', () async {
//     // Arrange
//     const movie = MovieTable(
//       id: 1,
//       title: 'Movie Title',
//       posterPath: 'assets/circle-g.png',
//       overview: 'Movie Overview',
//     );

//     // Insert a movie first
//     await databaseHelper.insertWatchlist(movie);

//     // Act
//     final result = await databaseHelper.removeWatchlist(movie);

//     // Assert
//     expect(result, 1); // The result should be the number of rows affected
//   });

//   test('Get watchlist movies', () async {
//     // Arrange
//     const movie1 = MovieTable(
//       id: 1,
//       title: 'Movie Title 1',
//       posterPath: 'assets/circle-g.png',
//       overview: 'Movie Overview 1',
//     );
//     const movie2 = MovieTable(
//       id: 2,
//       title: 'Movie Title 2',
//       posterPath: 'assets/circle-g.png',
//       overview: 'Movie Overview 2',
//     );

//     // Insert movies
//     await databaseHelper.insertWatchlist(movie1);
//     await databaseHelper.insertWatchlist(movie2);

//     // Act
//     final result = await databaseHelper.getWatchlistMovies();

//     // Assert
//     expect(result.length, 2);
//     expect(result[0]['title'], 'Movie Title 1');
//     expect(result[1]['title'], 'Movie Title 2');
//   });

//   test('Insert duplicate movie should fail', () async {
//     // Arrange
//     const movie = MovieTable(
//       id: 1,
//       title: 'Movie Title',
//       posterPath: 'assets/circle-g.png',
//       overview: 'Movie Overview',
//     );

//     // Act
//     await databaseHelper.insertWatchlist(movie);

//     try {
//       await databaseHelper.insertWatchlist(movie);
//       // If no exception is thrown, the test should fail
//       fail('Expected an exception when inserting a duplicate movie');
//     } catch (e) {
//       // Assert
//       expect(
//           e, isA<DatabaseException>()); // Ensure a DatabaseException is thrown
//       expect(
//           (e as DatabaseException).toString(),
//           contains(
//               'UNIQUE constraint failed')); // Check that the error is due to a UNIQUE constraint violation
//     }
//   });
// }

import 'package:ditonton/features/movie/data/models/movie_table.dart';
import 'package:ditonton/features/movie/data/datasources/db/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    // Initialize sqflite ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    // Clear the watchlist table before each test
    await db!.execute('DELETE FROM watchlist');
  });

  test('Insert watchlist movie', () async {
    // Arrange
    const movie = MovieTable(
      id: 1,
      title: 'Movie Title',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview',
    );

    // Act
    final result = await databaseHelper.insertWatchlist(movie);

    // Assert
    expect(result, 1); // The result should be the ID of the inserted row
  });

  test('Remove watchlist movie', () async {
    // Arrange
    const movie = MovieTable(
      id: 1,
      title: 'Movie Title',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview',
    );

    // Insert a movie first
    await databaseHelper.insertWatchlist(movie);

    // Act
    final result = await databaseHelper.removeWatchlist(movie);

    // Assert
    expect(result, 1); // The result should be the number of rows affected
  });

  test('Get watchlist movies', () async {
    // Arrange
    const movie1 = MovieTable(
      id: 1,
      title: 'Movie Title 1',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview 1',
    );
    const movie2 = MovieTable(
      id: 2,
      title: 'Movie Title 2',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview 2',
    );

    // Insert movies
    await databaseHelper.insertWatchlist(movie1);
    await databaseHelper.insertWatchlist(movie2);

    // Act
    final result = await databaseHelper.getWatchlistMovies();

    // Assert
    expect(result.length, 2);
    expect(result[0]['title'], 'Movie Title 1');
    expect(result[1]['title'], 'Movie Title 2');
  });

  test('Insert duplicate movie should fail', () async {
    // Arrange
    const movie = MovieTable(
      id: 1,
      title: 'Movie Title',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview',
    );

    // Act
    await databaseHelper.insertWatchlist(movie);

    try {
      await databaseHelper.insertWatchlist(movie);
      // If no exception is thrown, the test should fail
      fail('Expected an exception when inserting a duplicate movie');
    } catch (e) {
      // Assert
      expect(
          e, isA<DatabaseException>()); // Ensure a DatabaseException is thrown
      expect(
          (e as DatabaseException).toString(),
          contains(
              'UNIQUE constraint failed')); // Check that the error is due to a UNIQUE constraint violation
    }
  });

  test('Remove non-existing movie should return 0', () async {
    // Arrange
    const movie = MovieTable(
      id: 999, // Assuming this ID does not exist
      title: 'Non-Existing Movie',
      posterPath: 'assets/circle-g.png',
      overview: 'Non-Existing Overview',
    );

    // Act
    final result = await databaseHelper.removeWatchlist(movie);

    // Assert
    expect(result, 0); // The result should be 0 because no rows were affected
  });

  test('Get movie by ID should return movie details', () async {
    // Arrange
    const movie = MovieTable(
      id: 1,
      title: 'Movie Title',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview',
    );

    // Insert a movie
    await databaseHelper.insertWatchlist(movie);

    // Act
    final result = await databaseHelper.getMovieById(1);

    // Assert
    expect(result, isNotNull);
    expect(result!['title'], 'Movie Title');
  });

  test('Get empty watchlist should return empty list', () async {
    // Act
    final result = await databaseHelper.getWatchlistMovies();

    // Assert
    expect(result, isEmpty); // The result should be an empty list
  });

  test('Insert and remove multiple movies', () async {
    // Arrange
    const movie1 = MovieTable(
      id: 1,
      title: 'Movie Title 1',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview 1',
    );
    const movie2 = MovieTable(
      id: 2,
      title: 'Movie Title 2',
      posterPath: 'assets/circle-g.png',
      overview: 'Movie Overview 2',
    );

    // Act
    await databaseHelper.insertWatchlist(movie1);
    await databaseHelper.insertWatchlist(movie2);

    // Assert
    var result = await databaseHelper.getWatchlistMovies();
    expect(result.length, 2);

    await databaseHelper.removeWatchlist(movie1);
    await databaseHelper.removeWatchlist(movie2);

    result = await databaseHelper.getWatchlistMovies();
    expect(result, isEmpty); // The watchlist should be empty after removal
  });
}
