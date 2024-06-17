import 'package:flutter/material.dart';
import 'package:movietime/src/model/movie.dart';
import 'package:movietime/src/page/widget/detail.dart';
import 'package:movietime/src/service/tmdb.dart';

class TopRateMovie extends StatefulWidget {
  const TopRateMovie({super.key});

  @override
  State<TopRateMovie> createState() => _TopRateMovieState();
}

class _TopRateMovieState extends State<TopRateMovie> {
  late final Future<List<MovieTopRate>> _movie;
  ApiService _apiService = ApiService();
  @override
  void initState() {
    super.initState();
    _movie = _apiService.fetchTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _movie,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          Center(
            child: Text("Error:${snapshot.error}"),
          );
        }
        return Padding(
          padding: EdgeInsets.all(8),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            physics: PageScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.48,
              crossAxisSpacing: 9,
              mainAxisSpacing: 9,
            ),
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MovieDetailScreen(movieId: movie.id);
                      }));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${movie.title}",
                    style: TextStyle(fontSize: 13.2),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
