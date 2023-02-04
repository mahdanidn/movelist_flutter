// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_test/bloc/moviedetail_bloc/moviedetail_bloc.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    super.key,
    required this.movieId,
  });

  final String movieId;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    context.read<MoviedetailBloc>().add(MoviedetailEventFetch(widget.movieId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Movie"),
      ),
      body: BlocBuilder<MoviedetailBloc, MoviedetailState>(
        builder: (context, state) {
          if (state is MoviedetailSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/original/${state.moviedetail.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.moviedetail.originalTitle ?? '-',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          state.moviedetail.overview ?? '-',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
