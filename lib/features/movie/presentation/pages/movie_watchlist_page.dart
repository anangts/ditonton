import 'package:ditonton/features/movie/presentation/bloc/bloc_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movie/presentation/widgets/movie_card_list.dart';

class MovieWatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const MovieWatchlistPage({super.key});

  @override
  State<MovieWatchlistPage> createState() => _MovieWatchlistPageState();
}

class _MovieWatchlistPageState extends State<MovieWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<MovieWatchlistBloc>().add(FetchWatchlistMovies());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<MovieWatchlistBloc>().add(FetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
          builder: (context, state) {
            if (state.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.watchlistState == RequestState.loaded) {
              if (state.watchlistMovies.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.watchlistMovies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.watchlistMovies.length,
                );
              } else {
                // Show text when the watchlist is empty
                return const Center(
                  child: Text('Watchlist is empty'),
                );
              }
            } else if (state.watchlistState == RequestState.error) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: SizedBox(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
