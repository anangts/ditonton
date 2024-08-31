// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/features/movie/presentation/pages/watchlist_movies_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i7;
import 'package:ditonton/features/movie/domain/usecases/get_watchlist_movies.dart'
    as _i2;
import 'package:ditonton/features/movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart'
    as _i4;
import 'package:ditonton/features/movie/presentation/bloc/movie_watchlist/movie_watchlist_event.dart'
    as _i6;
import 'package:ditonton/features/movie/presentation/bloc/movie_watchlist/movie_watchlist_state.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetWatchlistMovies_0 extends _i1.SmartFake
    implements _i2.GetWatchlistMovies {
  _FakeGetWatchlistMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieWatchlistState_1 extends _i1.SmartFake
    implements _i3.MovieWatchlistState {
  _FakeMovieWatchlistState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieWatchlistBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieWatchlistBloc extends _i1.Mock
    implements _i4.MovieWatchlistBloc {
  MockMovieWatchlistBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies => (super.noSuchMethod(
        Invocation.getter(#getWatchlistMovies),
        returnValue: _FakeGetWatchlistMovies_0(
          this,
          Invocation.getter(#getWatchlistMovies),
        ),
      ) as _i2.GetWatchlistMovies);

  @override
  _i3.MovieWatchlistState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieWatchlistState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.MovieWatchlistState);

  @override
  _i5.Stream<_i3.MovieWatchlistState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i3.MovieWatchlistState>.empty(),
      ) as _i5.Stream<_i3.MovieWatchlistState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i6.MovieWatchlistEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i6.MovieWatchlistEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.MovieWatchlistState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i6.MovieWatchlistEvent>(
    _i7.EventHandler<E, _i3.MovieWatchlistState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i7.Transition<_i6.MovieWatchlistEvent, _i3.MovieWatchlistState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void onChange(_i7.Change<_i3.MovieWatchlistState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
