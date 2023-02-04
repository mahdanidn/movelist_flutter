part of 'moviedetail_bloc.dart';

abstract class MoviedetailState extends Equatable {
  const MoviedetailState();

  @override
  List<Object> get props => [];
}

class MoviedetailInitial extends MoviedetailState {}

class MoviedetailLoading extends MoviedetailState {}

class MoviedetailSuccess extends MoviedetailState {
  MovieDetail moviedetail;

  MoviedetailSuccess(this.moviedetail);
}
