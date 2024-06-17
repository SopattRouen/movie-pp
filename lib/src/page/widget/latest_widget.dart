import 'package:flutter/material.dart';
import 'package:movietime/src/enum/theme.dart';
import 'package:movietime/src/model/movie.dart';
import 'package:movietime/src/page/widget/detail.dart';
import 'package:movietime/src/page/widget/top-rate.dart';
import 'package:movietime/src/service/tmdb.dart';
import 'package:provider/provider.dart';

class GenreWidget extends StatefulWidget {
  const GenreWidget({Key? key}) : super(key: key);

  @override
  _GenreWidgetState createState() => _GenreWidgetState();
}

class _GenreWidgetState extends State<GenreWidget> {
  late Future<List<Genre>> _genreData;
  final GenreService _genreService = GenreService();

  @override
  void initState() {
    super.initState();
    _genreData = _genreService.fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder<List<Genre>>(
      future: _genreData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Genre> genres = snapshot.data!;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < genres.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: themeProvider.isDarkMode
                                  ? Colors.black
                                  : Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${genres[i].name}",
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Latest Video"),
                    Text(
                      "See All",
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ],
                ),
              ),
              LatestWidget(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Top Rate Video"),
                    Text(
                      "See All",
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ],
                ),
              ),
              TopRateMovie(),
            ],
          );
        }
      },
    );
  }
}

class LatestWidget extends StatefulWidget {
  const LatestWidget({super.key});

  @override
  State<LatestWidget> createState() => _LatestWidgetState();
}

class _LatestWidgetState extends State<LatestWidget> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _movieService.fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.isEmpty) {
          return Center(child: Text("No Data"));
        } else if (snapshot.hasError) {
          return Text("Error:${snapshot.error}");
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
                        return MovieDetailScreen(
                          movieId: movie.id,
                        );
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
                  Text("${movie.title}"),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
