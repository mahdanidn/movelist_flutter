part of 'moviedetail_bloc.dart';

abstract class MoviedetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviedetailEventFetch extends MoviedetailEvent {
  MoviedetailEventFetch(this.movieId);

  final String movieId;
}
