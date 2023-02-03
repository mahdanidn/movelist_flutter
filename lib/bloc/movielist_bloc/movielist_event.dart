part of 'movielist_bloc.dart';

abstract class MovielistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieListFetch extends MovielistEvent {}
