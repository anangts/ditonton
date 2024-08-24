import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movie/presentation/pages/about_page.dart';
import 'package:ditonton/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movie/presentation/pages/home_movie_page.dart';
import 'package:ditonton/features/movie/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/search_page.dart';
import 'package:ditonton/features/movie/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movie/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/features/movie/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/features/movie/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/features/movie/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/features/movie/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/features/movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/features/movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_movie_detail_page.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_movie_page.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_popular_page.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_search_page.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_top_rated_page.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_watchlist_page.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_top_rated_notifier.dart';
import 'package:ditonton/features/tv/presentation/provider/tv_watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        //TV Series
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
            case SearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            //TV Series
            case HomeTvPage.routeName:
              return MaterialPageRoute(builder: (_) => const HomeTvPage());
            case PopularTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case TopRatedTvPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case TvDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id), settings: settings);
            case TvSearchPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TvSearchPage());
            case WatchlistTvPage.routeName:
              return MaterialPageRoute(builder: (_) => const WatchlistTvPage());

            case AboutPage.routeName:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
