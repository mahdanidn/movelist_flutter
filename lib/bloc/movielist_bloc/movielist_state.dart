part of 'movielist_bloc.dart';

enum MovielistStatus { initial, success, failure }

class MovielistState extends Equatable {
  const MovielistState({
    this.status = MovielistStatus.initial,
    this.resultMovies = const <MovieListModel>[],
  });

  final MovielistStatus status;
  final List<MovieListModel> resultMovies;

  MovielistState copyWith({
    MovielistStatus? status,
    List<MovieListModel>? resultMovies,
  }) {
    return MovielistState(
      status: status ?? this.status,
      resultMovies: resultMovies ?? this.resultMovies,
    );
  }

  @override
  List<Object> get props => [status, resultMovies];
}
