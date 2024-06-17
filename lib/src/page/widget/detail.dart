import 'package:flutter/material.dart';
import 'package:movietime/src/model/movie.dart';
import 'package:movietime/src/service/tmdb.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetail> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = MovieDetailService().fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder<MovieDetail>(
        future: futureMovie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.overview),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Release Date: ${movie.releaseDate}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Runtime: ${movie.runtime} minutes'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Genres: ${movie.genres.join(', ')}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Rating: ${movie.voteAverage}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Tagline: ${movie.tagline}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: movie.videos.map((video) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: video.key,
                              
                              flags: YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                                enableCaption: true,
                                controlsVisibleAtStart: true,
                              ),
                            ),
                            showVideoProgressIndicator: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
