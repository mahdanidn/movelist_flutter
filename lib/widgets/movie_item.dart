import 'package:flutter/material.dart';
import 'package:moviedb_test/models/movelist_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.movieTitle,
    required this.id,
  }) : super(key: key);

  // final MovieListModel movie;
  final int id;
  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${id}', style: textTheme.caption),
        title: Text(movieTitle),
        isThreeLine: true,
        subtitle: Text('asd'),
        dense: true,
      ),
    );
  }
}
