import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv/domain/entities/tv.dart';
import 'package:ditonton/features/tv/presentation/bloc/bloc_export.dart';
import 'package:ditonton/features/tv/presentation/pages/tv_watchlist_page.dart';
import 'package:ditonton/features/tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tv_watchlist_page_test.mocks.dart';
 

@GenerateMocks([TvWatchlistBloc])
void main() {
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvWatchlistBloc = MockTvWatchlistBloc();

    // Stub the stream and close methods
    when(mockTvWatchlistBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockTvWatchlistBloc.state).thenReturn(const TvWatchlistState());
    when(mockTvWatchlistBloc.close()).thenAnswer((_) async {
      return;
    });
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistBloc>.value(
      value: mockTvWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvWatchlistBloc.state).thenReturn(const TvWatchlistState(
      watchlistState: RequestState.loading,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));
    await tester.pump();

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display ListView when state is loaded with tvs',
      (WidgetTester tester) async {
    // Arrange
    final tvs = [
      Tv(
        id: 1,
        name: 'Test Tv',
        overview: 'Test Overview',
        posterPath: '/test.jpg',
      ),
    ];
    when(mockTvWatchlistBloc.state).thenReturn(TvWatchlistState(
      watchlistState: RequestState.loaded,
      watchlistTv: tvs,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));
    await tester.pump();

    // Assert
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should display empty message when watchlist is empty',
      (WidgetTester tester) async {
    // Arrange
    when(mockTvWatchlistBloc.state).thenReturn(const TvWatchlistState(
      watchlistState: RequestState.loaded,
      watchlistTv: [],
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));
    await tester.pump();

    // Assert
    expect(find.text('Watchlist is empty'), findsOneWidget);
  });

  testWidgets('should display error message when state is error',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Failed to fetch data';
    when(mockTvWatchlistBloc.state).thenReturn(const TvWatchlistState(
      watchlistState: RequestState.error,
      message: errorMessage,
    ));

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));
    await tester.pump();

    // Assert
    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}
