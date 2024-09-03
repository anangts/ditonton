import 'package:ditonton/features/tv/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/features/tv/data/models/tv_table.dart';
import 'package:ditonton/features/tv/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late TvDatabaseHelper databaseHelper;

  setUpAll(() {
    // Initialize sqflite ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseHelper = TvDatabaseHelper();
    final db = await databaseHelper.database;

    // Clear the watchlist table before each test
    await db!.execute('DELETE FROM watchlistTv');
  });

  test('Insert watchlist tv', () async {
    // Arrange
    const tv = TvTable(
      id: 1,
      name: 'Tv Title',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview',
    );

    // Act
    final result = await databaseHelper.insertWatchlist(tv);

    // Assert
    expect(result, 1); // The result should be the ID of the inserted row
  });

  test('Remove watchlist tv', () async {
    // Arrange
    const tv = TvTable(
      id: 1,
      name: 'Tv Title',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview',
    );

    // Insert a tv first
    await databaseHelper.insertWatchlist(tv);

    // Act
    final result = await databaseHelper.removeWatchlist(tv);

    // Assert
    expect(result, 1); // The result should be the number of rows affected
  });

  test('Get watchlist tv', () async {
    // Arrange
    const tv1 = TvTable(
      id: 1,
      name: 'Tv Title 1',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview 1',
    );
    const tv2 = TvTable(
      id: 2,
      name: 'Tv Title 2',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview 2',
    );

    // Insert tv
    await databaseHelper.insertWatchlist(tv1);
    await databaseHelper.insertWatchlist(tv2);

    // Act
    final result = await databaseHelper.getWatchlistTvs();

    // Assert
    expect(result.length, 2);
    expect(result[0]['name'], 'Tv Title 1');
    expect(result[1]['name'], 'Tv Title 2');
  });

  test('Insert duplicate tv should fail', () async {
    // Arrange
    const tv = TvTable(
      id: 1,
      name: 'Tv Title',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview',
    );

    // Act
    await databaseHelper.insertWatchlist(tv);

    try {
      await databaseHelper.insertWatchlist(tv);
      // If no exception is thrown, the test should fail
      fail('Expected an exception when inserting a duplicate tv');
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

  test('Remove non-existing tv should return 0', () async {
    // Arrange
    const tv = TvTable(
      id: 999, // Assuming this ID does not exist
      name: 'Non-Existing Tv',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Non-Existing Overview',
    );

    // Act
    final result = await databaseHelper.removeWatchlist(tv);

    // Assert
    expect(result, 0); // The result should be 0 because no rows were affected
  });

  test('Get tv by ID should return tv details', () async {
    // Arrange
    const tv = TvTable(
      id: 1,
      name: 'Tv Title',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview',
    );

    // Insert a tv
    await databaseHelper.insertWatchlist(tv);

    // Act
    final result = await databaseHelper.getTvById(1);

    // Assert
    expect(result, isNotNull);
    expect(result!['name'], 'Tv Title');
  });

  test('Get empty watchlist should return empty list', () async {
    // Act
    final result = await databaseHelper.getWatchlistTvs();

    // Assert
    expect(result, isEmpty); // The result should be an empty list
  });

  test('Insert and remove multiple tv', () async {
    // Arrange
    const tv1 = TvTable(
      id: 1,
      name: 'Tv Title 1',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview 1',
    );
    const tv2 = TvTable(
      id: 2,
      name: 'Tv Title 2',
      posterPath: 'assets/logo/circle-g.png',
      overview: 'Tv Overview 2',
    );

    // Act
    await databaseHelper.insertWatchlist(tv1);
    await databaseHelper.insertWatchlist(tv2);

    // Assert
    var result = await databaseHelper.getWatchlistTvs();
    expect(result.length, 2);

    await databaseHelper.removeWatchlist(tv1);
    await databaseHelper.removeWatchlist(tv2);

    result = await databaseHelper.getWatchlistTvs();
    expect(result, isEmpty); // The watchlist should be empty after removal
  });
}
