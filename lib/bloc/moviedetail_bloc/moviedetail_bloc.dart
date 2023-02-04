import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_test/helpers/constant.dart';
import 'package:http/http.dart' as http;
import 'package:moviedb_test/models/moviedetail_model.dart';

part 'moviedetail_event.dart';
part 'moviedetail_state.dart';

class MoviedetailBloc extends Bloc<MoviedetailEvent, MoviedetailState> {
  MoviedetailBloc() : super(MoviedetailInitial()) {
    on<MoviedetailEventFetch>((event, emit) async {
      final response = await http.get(
        Uri.https(
          Constant.apiUrl,
          '/3/movie/${event.movieId}',
          <String, String>{'api_key': Constant.apiKey},
        ),
      );

      emit(MoviedetailLoading());

      if (response.statusCode == 200) {
        final result = movieDetailFromJson(response.body.toString());
        emit(MoviedetailSuccess(result));
      }
    });
  }
}
