import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_test/bloc/movielist_bloc/movielist_bloc.dart';
import 'package:moviedb_test/screen/movie_listdata.dart';
import 'package:http/http.dart' as http;

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MovieListData(),
    Text(
      'Hai',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "List Movie" : "List Favorite"),
      ),
      body: BlocProvider(
        create: (context) =>
            MovielistBloc(httpClient: http.Client())..add(MovieListFetch()),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
