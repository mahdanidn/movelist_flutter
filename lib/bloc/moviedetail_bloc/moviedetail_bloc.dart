import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_test/helpers/constant.dart';
import 'package:http/http.dart' as http;

part 'moviedetail_event.dart';
part 'moviedetail_state.dart';

class MoviedetailBloc extends Bloc<MoviedetailEvent, MoviedetailState> {
  MoviedetailBloc() : super(MoviedetailInitial()) {
    on<MoviedetailEvent>((event, emit) async {
      final response = await http.get(
        Uri.https(
          Constant.apiUrl,
          '/3/movie/${event.movieId}',
          <String, String>{'api_key': Constant.apiKey},
        ),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        print(body);
      }
    });
  }
}
