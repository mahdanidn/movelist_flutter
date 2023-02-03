import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_test/bloc/bloc/movielist_bloc.dart';
import 'package:moviedb_test/widgets/bottom_loader.dart';
import 'package:moviedb_test/widgets/movie_item.dart';

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Movie"),
      ),
      body: BlocBuilder<MovielistBloc, MovielistState>(
        builder: (context, state) {
          switch (state.status) {
            case MovielistStatus.failure:
              return const Center(child: Text('failed to fetch movie'));
            case MovielistStatus.success:
            // if (state.resultMovies.isEmpty) {
            //   return const Center(child: Text('no movies'));
            // }
            // return ListView.builder(
            //   itemBuilder: (BuildContext context, int index) {
            //     return index >= state.resultMovies.length
            //         ? BottomLoader()
            //         : MovieItem(movie: state.resultMovies[index]);
            //   },
            //   itemCount: state.hasReachedMax
            //       ? state.resultMovies.length
            //       : state.resultMovies.length + 1,
            //   controller: _scrollController,
            // );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
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
