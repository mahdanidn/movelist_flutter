part of 'movielist_bloc.dart';

enum MovielistStatus { initial, success, failure }

class MovielistState extends Equatable {
  const MovielistState({
    this.status = MovielistStatus.initial,
    this.hasReachedMax = false,
  });

  final MovielistStatus status;
  final bool hasReachedMax;

  MovielistState copyWith({
    MovielistStatus? status,
    bool? hasReachedMax,
  }) {
    return MovielistState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, hasReachedMax];
}
