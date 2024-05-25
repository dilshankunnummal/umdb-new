import 'package:flutter/material.dart';
import 'package:umdb/pages/top_rated_movies_page.dart';

class NewTopRatedMovies extends StatefulWidget {
  const NewTopRatedMovies({super.key});

  @override
  State<NewTopRatedMovies> createState() => _NewTopRatedMoviesState();
}

class _NewTopRatedMoviesState extends State<NewTopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: const TopRatedMoviesPage(),
    );
  }
}