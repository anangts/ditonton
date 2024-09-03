import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/movie/presentation/bloc/bloc_export.dart';
import 'features/movie/presentation/pages/page.dart';
import 'features/tv/presentation/bloc/bloc_export.dart';
import 'features/tv/presentation/pages/page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        // Tv Series
        BlocProvider(
          create: (_) => di.locator<TvListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
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
        //home: const MovieHomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MovieHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const MovieHomePage());
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case MovieTopRatedPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const MovieTopRatedPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
            case MovieSearchPage.routeName:
              return CupertinoPageRoute(
                  builder: (_) => const MovieSearchPage());
            case MovieWatchlistPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const MovieWatchlistPage());
            //TV Series
            case TvHomePage.routeName:
              return MaterialPageRoute(builder: (_) => const TvHomePage());
            case TvPopularPage.routeName:
              return CupertinoPageRoute(builder: (_) => const TvPopularPage());
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
