import 'package:equatable/equatable.dart';

abstract class TopRatedMoviesEvent extends Equatable {
  const TopRatedMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopRatedMovie extends TopRatedMoviesEvent {}

