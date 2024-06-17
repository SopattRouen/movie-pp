import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movietime/src/model/movie.dart';
import 'package:movietime/src/service/tmdb.dart';

class ScrollWidget extends StatefulWidget {
  const ScrollWidget({Key? key});

  @override
  State<ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  final MovieService _movieService = MovieService();
  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _movieService.fetchPopularMovies();
  }

  int currentIndex = 0;
  final CarouselController controller = CarouselController();

  Widget buildIndicator(List<Movie> movies) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: movies.asMap().entries.map(
        (entry) {
          return GestureDetector(
            onTap: () {
              controller.jumpToPage(entry.key);
              setState(() {
                currentIndex = entry.key;
              });
            },
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentIndex == entry.key ? Colors.black54 : Colors.white70,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _movies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final movies = snapshot.data!;
          return Stack(
            children: [
              CarouselSlider.builder(
                carouselController: controller,
                itemCount: movies.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = movies[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.23,
                  reverse: false,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: buildIndicator(movies),
              ),
            ],
          );
        }
      },
    );
  }
}
