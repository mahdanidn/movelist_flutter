part of 'movielist_bloc.dart';

enum MovielistStatus { initial, success, failure }

class MovielistState extends Equatable {
  const MovielistState({
    this.status = MovielistStatus.initial,
    this.resultMovies = const <MovieListModel>[],
    this.hasReachedMax = false,
  });

  final MovielistStatus status;
  final bool hasReachedMax;
  final List<MovieListModel> resultMovies;

  MovielistState copyWith({
    MovielistStatus? status,
    List<MovieListModel>? resultMovies,
    bool? hasReachedMax,
  }) {
    return MovielistState(
      status: status ?? this.status,
      resultMovies: resultMovies ?? this.resultMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, hasReachedMax];
}
