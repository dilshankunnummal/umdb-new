import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:umdb/pages/new_popular_page.dart';
import 'package:umdb/pages/new_top_rated_page.dart';

import '../models/movie.dart';

class MovieGridscreen extends StatefulWidget {
  const MovieGridscreen({super.key});

  @override
  State<MovieGridscreen> createState() => _MovieGridscreenState();
}

class _MovieGridscreenState extends State<MovieGridscreen> {
  Future<MovieList>? topRatedMovies;
  Future<MovieList>? futureMovies;

  Future<MovieList> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/popular_movies.json');
    final jsonResponse = json.decode(jsonString);
    return MovieList.fromJson(jsonResponse);
  }

  Future<MovieList> fetchTopRatedMovies() async {
    final response = await http.get(Uri.parse('https://movie-api-rish.onrender.com/top-rated'));

    if (response.statusCode == 200) {
      final jsonResponse2 = json.decode(response.body);
      return MovieList.fromJson(jsonResponse2);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovies = loadJsonData();
    topRatedMovies = fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Movie App'),
      // ),
      backgroundColor: Colors.purple[100],
      body: Padding(
        padding: const EdgeInsets.only(top: 46.0, left: 16.0, right: 16.0),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Movies',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewPopularMovies()),
                        );
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),


            Expanded(
              child: FutureBuilder<MovieList>(
                future: futureMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final movies = snapshot.data?.items ?? [];
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 2 rows and 3 columns
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(movies[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(movies[index].year),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Rated Movies',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewTopRatedMovies()),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: FutureBuilder<MovieList>(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final topMovies = snapshot.data?.items ?? [];
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,// 2 rows and 3 columns
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(topMovies[index].title, style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(topMovies[index].year),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}