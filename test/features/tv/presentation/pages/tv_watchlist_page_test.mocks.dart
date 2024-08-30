// // Mocks generated by Mockito 5.4.4 from annotations
// // in ditonton/test/features/tv/presentation/pages/tv_watchlist_page_test.dart.
// // Do not manually edit this file.

// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'dart:async' as _i7;
// import 'dart:ui' as _i8;

// import 'package:ditonton/common/state_enum.dart' as _i5;
// import 'package:ditonton/features/tv/domain/entities/tv.dart' as _i4;
// import 'package:ditonton/features/tv/domain/usecases/tv_get_watchlist.dart'
//     as _i2;
// import 'package:ditonton/features/tv/presentation/provider/tv_watchlist_notifier.dart'
//     as _i3;
// import 'package:mockito/mockito.dart' as _i1;
// import 'package:mockito/src/dummies.dart' as _i6;

// // ignore_for_file: type=lint
// // ignore_for_file: avoid_redundant_argument_values
// // ignore_for_file: avoid_setters_without_getters
// // ignore_for_file: comment_references
// // ignore_for_file: deprecated_member_use
// // ignore_for_file: deprecated_member_use_from_same_package
// // ignore_for_file: implementation_imports
// // ignore_for_file: invalid_use_of_visible_for_testing_member
// // ignore_for_file: prefer_const_constructors
// // ignore_for_file: unnecessary_parenthesis
// // ignore_for_file: camel_case_types
// // ignore_for_file: subtype_of_sealed_class

// class _FakeGetTvWatchlist_0 extends _i1.SmartFake
//     implements _i2.TvGetWatchlist {
//   _FakeGetTvWatchlist_0(
//     Object parent,
//     Invocation parentInvocation,
//   ) : super(
//           parent,
//           parentInvocation,
//         );
// }

// /// A class which mocks [WatchlistTvNotifier].
// ///
// /// See the documentation for Mockito's code generation for more information.
// class MockWatchlistTvNotifier extends _i1.Mock
//     implements _i3.WatchlistTvNotifier {
//   MockWatchlistTvNotifier() {
//     _i1.throwOnMissingStub(this);
//   }

//   @override
//   _i2.TvGetWatchlist get getWatchlistTv => (super.noSuchMethod(
//         Invocation.getter(#getWatchlistTv),
//         returnValue: _FakeGetTvWatchlist_0(
//           this,
//           Invocation.getter(#getWatchlistTv),
//         ),
//       ) as _i2.TvGetWatchlist);

//   @override
//   List<_i4.Tv> get watchlistTv => (super.noSuchMethod(
//         Invocation.getter(#watchlistTv),
//         returnValue: <_i4.Tv>[],
//       ) as List<_i4.Tv>);

//   @override
//   _i5.RequestState get watchlistState => (super.noSuchMethod(
//         Invocation.getter(#watchlistState),
//         returnValue: _i5.RequestState.empty,
//       ) as _i5.RequestState);

//   @override
//   String get message => (super.noSuchMethod(
//         Invocation.getter(#message),
//         returnValue: _i6.dummyValue<String>(
//           this,
//           Invocation.getter(#message),
//         ),
//       ) as String);

//   @override
//   bool get hasListeners => (super.noSuchMethod(
//         Invocation.getter(#hasListeners),
//         returnValue: false,
//       ) as bool);

//   @override
//   _i7.Future<void> fetchWatchlistTv() => (super.noSuchMethod(
//         Invocation.method(
//           #fetchWatchlistTv,
//           [],
//         ),
//         returnValue: _i7.Future<void>.value(),
//         returnValueForMissingStub: _i7.Future<void>.value(),
//       ) as _i7.Future<void>);

//   @override
//   void addListener(_i8.VoidCallback? listener) => super.noSuchMethod(
//         Invocation.method(
//           #addListener,
//           [listener],
//         ),
//         returnValueForMissingStub: null,
//       );

//   @override
//   void removeListener(_i8.VoidCallback? listener) => super.noSuchMethod(
//         Invocation.method(
//           #removeListener,
//           [listener],
//         ),
//         returnValueForMissingStub: null,
//       );

//   @override
//   void dispose() => super.noSuchMethod(
//         Invocation.method(
//           #dispose,
//           [],
//         ),
//         returnValueForMissingStub: null,
//       );

//   @override
//   void notifyListeners() => super.noSuchMethod(
//         Invocation.method(
//           #notifyListeners,
//           [],
//         ),
//         returnValueForMissingStub: null,
//       );
// }
