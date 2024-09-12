import 'dart:io';

import 'package:ditonton/common/ssl_pinning.dart';
import 'package:ditonton/features/movie/data/datasources/db/database_helper.dart';
import 'package:ditonton/features/movie/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movie/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movie/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/features/tv/data/datasources/db/tv_database_helper.dart';
import 'package:ditonton/features/tv/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/features/tv/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/features/tv/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_detail.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_now_playing.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_popular.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_recommendations.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_top_rated.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_watchlist.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_get_watchlist_status.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_remove_watchlist.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_save_watchlist.dart';
import 'package:ditonton/features/tv/domain/usecases/tv_search.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

import 'features/movie/presentation/bloc/bloc_export.dart';
import 'features/tv/domain/repositories/tv_repository.dart';
import 'features/tv/presentation/bloc/bloc_export.dart';

final locator = GetIt.instance;

void init() {
  locator.registerLazySingleton<IOClient>(() {
    return IOClient(HttpClient());
  });

  // Register BLoCs instead of Notifiers
  locator.registerFactory(
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
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<SSLPinning>(() => SSLPinning());

  // Register MovieRemoteDataSourceImpl with injected dependency
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sslPinning: locator()),
  );
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
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
