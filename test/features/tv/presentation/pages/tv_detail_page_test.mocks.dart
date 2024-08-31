// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/features/tv/presentation/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i7;
import 'package:ditonton/features/tv/domain/usecases/usecases.dart' as _i2;
import 'package:ditonton/features/tv/presentation/bloc/tv_detail/tv_detail_bloc.dart'
    as _i4;
import 'package:ditonton/features/tv/presentation/bloc/tv_detail/tv_detail_event.dart'
    as _i6;
import 'package:ditonton/features/tv/presentation/bloc/tv_detail/tv_detail_state.dart'
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

class _FakeTvGetDetail_0 extends _i1.SmartFake implements _i2.TvGetDetail {
  _FakeTvGetDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvGetRecommendations_1 extends _i1.SmartFake
    implements _i2.TvGetRecommendations {
  _FakeTvGetRecommendations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvGetWatchListStatus_2 extends _i1.SmartFake
    implements _i2.TvGetWatchListStatus {
  _FakeTvGetWatchListStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSaveWatchlist_3 extends _i1.SmartFake
    implements _i2.TvSaveWatchlist {
  _FakeTvSaveWatchlist_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvRemoveWatchlist_4 extends _i1.SmartFake
    implements _i2.TvRemoveWatchlist {
  _FakeTvRemoveWatchlist_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetailState_5 extends _i1.SmartFake implements _i3.TvDetailState {
  _FakeTvDetailState_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailBloc extends _i1.Mock implements _i4.TvDetailBloc {
  MockTvDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvGetDetail get getTvDetail => (super.noSuchMethod(
        Invocation.getter(#getTvDetail),
        returnValue: _FakeTvGetDetail_0(
          this,
          Invocation.getter(#getTvDetail),
        ),
      ) as _i2.TvGetDetail);

  @override
  _i2.TvGetRecommendations get getTvRecommendations => (super.noSuchMethod(
        Invocation.getter(#getTvRecommendations),
        returnValue: _FakeTvGetRecommendations_1(
          this,
          Invocation.getter(#getTvRecommendations),
        ),
      ) as _i2.TvGetRecommendations);

  @override
  _i2.TvGetWatchListStatus get getWatchListStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListStatus),
        returnValue: _FakeTvGetWatchListStatus_2(
          this,
          Invocation.getter(#getWatchListStatus),
        ),
      ) as _i2.TvGetWatchListStatus);

  @override
  _i2.TvSaveWatchlist get saveWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveWatchlist),
        returnValue: _FakeTvSaveWatchlist_3(
          this,
          Invocation.getter(#saveWatchlist),
        ),
      ) as _i2.TvSaveWatchlist);

  @override
  _i2.TvRemoveWatchlist get removeWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeWatchlist),
        returnValue: _FakeTvRemoveWatchlist_4(
          this,
          Invocation.getter(#removeWatchlist),
        ),
      ) as _i2.TvRemoveWatchlist);

  @override
  _i3.TvDetailState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTvDetailState_5(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.TvDetailState);

  @override
  _i5.Stream<_i3.TvDetailState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i3.TvDetailState>.empty(),
      ) as _i5.Stream<_i3.TvDetailState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i6.TvDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i6.TvDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.TvDetailState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i6.TvDetailEvent>(
    _i7.EventHandler<E, _i3.TvDetailState>? handler, {
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
          _i7.Transition<_i6.TvDetailEvent, _i3.TvDetailState>? transition) =>
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
  void onChange(_i7.Change<_i3.TvDetailState>? change) => super.noSuchMethod(
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
