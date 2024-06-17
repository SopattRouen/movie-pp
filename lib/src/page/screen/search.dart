import 'package:flutter/material.dart';
import 'package:movietime/src/model/movie.dart';
import 'package:movietime/src/page/widget/detail.dart';
import 'package:movietime/src/service/tmdb.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> display = [];
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  final SearchService _service = SearchService();

  void search(String value) async {
    if (value.isEmpty) {
      setState(() {
        display.clear();
        isSearching = false;
      });
    } else {
      final movies = await _service.fetchMovies(value);
      setState(() {
        display = movies;
        isSearching = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 16, 9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 35,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 320,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                            size: 26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 170,
                            height: 60,
                            child: TextField(
                              controller: searchController,
                              onChanged: (value) => search(value),
                              decoration: InputDecoration(
                                hintText: "Search...",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isSearching && display.isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: display.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetailScreen(
                                movieId: display[index].id,
                              );
                            },
                          ),
                        ); // Uncomment if using GetX for navigation
                      },
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${display[index].posterPath}')),
                      ),
                      title: Text(
                        display[index].title,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            if (isSearching && display.isEmpty)
              Center(
                child: Text(
                  "No results found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
