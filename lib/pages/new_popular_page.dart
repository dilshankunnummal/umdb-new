import 'package:flutter/material.dart';
import 'package:umdb/pages/popular_movies_page.dart';
import 'package:umdb/widgets/popular_movie_list_cubit.dart';

class NewPopularMovies extends StatefulWidget {
  const NewPopularMovies({super.key});

  @override
  State<NewPopularMovies> createState() => _NewPopularMoviesState();
}

class _NewPopularMoviesState extends State<NewPopularMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: const PopularMoviesPage(),
    );
  }
}
