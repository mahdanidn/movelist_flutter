import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_test/bloc/movielist_bloc/movielist_bloc.dart';
import 'package:moviedb_test/widgets/bottom_loader.dart';
import 'package:moviedb_test/widgets/movie_item.dart';

class MovieListData extends StatefulWidget {
  const MovieListData({super.key});

  @override
  State<MovieListData> createState() => _MovieListDataState();
}

class _MovieListDataState extends State<MovieListData> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovielistBloc, MovielistState>(
      builder: (context, state) {
        // print(state.status);
        switch (state.status) {
          case MovielistStatus.failure:
            return const Center(child: Text('failed to fetch movie'));
          case MovielistStatus.success:
            if (state.resultMovies.isEmpty) {
              return const Center(child: Text('no movies'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.resultMovies.length
                    ? BottomLoader()
                    : MovieItem(
                        id: state.resultMovies[index].id,
                        posterImage: state.resultMovies[index].posterPath,
                        movieTitle: state.resultMovies[index].originalTitle,
                        movieDescription: state.resultMovies[index].overview,
                      );
              },
              itemCount: state.resultMovies.length,
              controller: _scrollController,
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MovielistBloc>().add(MovieListFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
