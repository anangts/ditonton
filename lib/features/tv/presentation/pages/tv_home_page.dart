import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/features/movie/presentation/pages/page.dart';
import 'package:ditonton/features/tv/domain/entities/entites.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/page.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvHomePage extends StatefulWidget {
  static const routeName = '/tv-home';
  const TvHomePage({super.key});

  @override
  State<TvHomePage> createState() => _TvHomePageState();
}

class _TvHomePageState extends State<TvHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        final tvListBloc = BlocProvider.of<TvListBloc>(context, listen: false);
        tvListBloc.add(FetchNowPlayingTv());
        tvListBloc.add(FetchPopularTvs());
        tvListBloc.add(FetchTopRatedTvs());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('saptrian24@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie_rounded),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, MovieHomePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv_rounded),
              title: const Text('TV Series'),
              onTap: () {
                Navigator.pushNamed(context, TvHomePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_rounded),
              title: const Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, MovieWatchlistPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_rounded),
              title: const Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Tv',
                    style: kHeading5,
                  ),
                ),
              ),
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.nowPlayingState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.nowPlayingState == RequestState.loaded) {
                    return TvList(state.tvNowPlaying);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, TvPopularPage.routeName),
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.tvPopularState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.tvPopularState == RequestState.loaded) {
                    return TvList(state.popularTvs);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.routeName),
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.tvTopRatedState == RequestState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.tvTopRatedState == RequestState.loaded) {
                    return TvList(state.tvTopRated);
                  } else {
                    return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
