import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_test/helpers/constant.dart';
import 'package:moviedb_test/models/movelist_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movielist_event.dart';
part 'movielist_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  MovielistBloc({required this.httpClient}) : super(const MovielistState()) {
    on<MovieListFetch>(
      _onMovieListFetch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onMovieListFetch(
    MovieListFetch event,
    Emitter<MovielistState> emit,
  ) async {
    try {
      if (state.status == MovielistStatus.initial) {
        final results = await _fetchMovies();
        return emit(state.copyWith(
          status: MovielistStatus.success,
          resultMovies: results,
        ));
      }

      final nextResult = await _fetchMovies(state.resultMovies.length);
      return emit(state.copyWith(
        status: MovielistStatus.success,
        resultMovies: [...state.resultMovies, ...nextResult],
      ));
    } catch (e) {
      emit(state.copyWith(status: MovielistStatus.failure));
    }
  }

  Future<List<MovieListModel>> _fetchMovies([int startPage = 1]) async {
    final response = await httpClient.get(
      Uri.https(
        Constant.apiUrl,
        '/3/discover/movie',
        <String, String>{'api_key': Constant.apiKey, 'page': '$startPage'},
      ),
    );

    // print(response.body);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      final result = body['results'] as List;

      return result.map((dynamic json) {
        return MovieListModel(
          id: json["id"],
          originalLanguage: json["original_language"],
          originalTitle: json["original_title"],
          overview: json["overview"],
          posterPath: json["poster_path"],
          title: json["title"],
        );
      }).toList();
    }
    throw Exception('error fetching moviedb');
  }
}
