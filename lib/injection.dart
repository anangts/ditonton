import 'dart:io';

import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/features/movie/domain/usecases/usecases.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

import 'features/movie/data/datasources/db/database_helper.dart';
import 'features/movie/data/datasources/movie_local_data_source.dart';
import 'features/movie/data/datasources/movie_remote_data_source.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/presentation/bloc/bloc_export.dart';
import 'features/tv/data/datasources/db/tv_database_helper.dart';
import 'features/tv/data/datasources/tv_local_data_source.dart';
import 'features/tv/data/datasources/tv_remote_data_source.dart';
import 'features/tv/data/repositories/movie_repository_impl.dart';
import 'features/tv/domain/repositories/tv_repository.dart';
import 'features/tv/domain/usecases/usecases.dart';
import 'features/tv/presentation/bloc/bloc_export.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SslPinning.ioClient;

  // external i.e. http client
  locator.registerLazySingleton<IOClient>(() => ioClient);

  // Register BLoCs instead of Notifiers
  locator.registerLazySingleton<MovieListBloc>(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchBloc(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton<GetNowPlayingMovies>(
      () => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton<GetPopularMovies>(
      () => GetPopularMovies(locator()));
  locator.registerLazySingleton<GetTopRatedMovies>(
      () => GetTopRatedMovies(locator()));
  locator
      .registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(locator()));
  locator.registerLazySingleton<GetMovieRecommendations>(
      () => GetMovieRecommendations(locator()));
  locator.registerLazySingleton<SearchMovies>(() => SearchMovies(locator()));
  locator.registerLazySingleton<GetWatchListStatus>(
      () => GetWatchListStatus(locator()));
  locator.registerLazySingleton<SaveWatchlist>(() => SaveWatchlist(locator()));
  locator
      .registerLazySingleton<RemoveWatchlist>(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton<GetWatchlistMovies>(
      () => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // http
  locator.registerLazySingleton<HttpClient>(() => HttpClient());

  // Register MovieRemoteDataSourceImpl
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(
            locator(),
          ));

  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // TV Series
  // Register BLoCs instead of Notifiers
  locator.registerFactory(
    () => TvListBloc(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSearchBloc(
      searchTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => TvPopularBloc(
      getPopularTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => TvTopRatedBloc(
      getTopRatedTv: locator(),
    ),
  );

  locator.registerFactory(
    () => TvWatchlistBloc(
      getWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => TvGetNowPlaying(locator()));
  locator.registerLazySingleton(() => TvGetPopular(locator()));
  locator.registerLazySingleton(() => TvGetTopRated(locator()));
  locator.registerLazySingleton(() => TvGetDetail(locator()));
  locator.registerLazySingleton(() => TvGetRecommendations(locator()));
  locator.registerLazySingleton(() => TvSearch(locator()));
  locator.registerLazySingleton(() => TvGetWatchListStatus(locator()));
  locator.registerLazySingleton(() => TvSaveWatchlist(locator()));
  locator.registerLazySingleton(() => TvRemoveWatchlist(locator()));
  locator.registerLazySingleton(() => TvGetWatchlist(locator()));

  // repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator
      .registerLazySingleton<TvRemoteDataSource>(() => TvRemoteDataSourceImpl(
            locator(),
          ));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
