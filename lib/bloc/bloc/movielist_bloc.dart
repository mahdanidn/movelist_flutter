import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'movielist_event.dart';
part 'movielist_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<MovielistEvent, MovielistState> {
  PostBloc({required this.httpClient}) : super(const MovielistState()) {
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
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovielistStatus.initial) {
        final results = await _fetchMovies();
        // return emit(state.copyWith(
        //   status: MovielistStatus.success,
        //   hasReachedMax: false,
        // ));
      }
      // final posts = await _fetchMovies(state.results.length);
      // results.isEmpty
      //     ? emit(state.copyWith(hasReachedMax: true))
      //     : emit(
      //         state.copyWith(
      //           status: MovielistStatus.success,
      //           hasReachedMax: false,
      //         ),
      //       );
    } catch (_) {
      emit(state.copyWith(status: MovielistStatus.failure));
    }
  }

  Future<List> _fetchMovies([int startPage = 1]) async {
    final response = await httpClient.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/discover/movie',
        <String, String>{
          'api_key': '463434dc0df28538dd81a04c115c0554',
          'page': '$startPage'
        },
      ),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print(body);
      // return body.map((dynamic json) {

      // }).toList();
    }
    throw Exception('error fetching posts');
  }
}
