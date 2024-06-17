import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movietime/src/model/movie.dart';

class MovieService {
  final String apiKey = '8f6a4a28323848f1c19c2c82cead5d06';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List movies = data['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

class GenreService {
  Future<List<Genre>> fetchGenres() async {
    final String baseUrl = 'https://api.themoviedb.org/3';
    final String apiKey =
        '8f6a4a28323848f1c19c2c82cead5d06'; // Replace with your API key
    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey&language=en'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<dynamic> genreList = jsonData['genres'];
      return genreList.map((json) => Genre.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }
}

class ApiService {
  static const String apiKey = '8f6a4a28323848f1c19c2c82cead5d06';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<MovieTopRate>> fetchTopRatedMovies() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> results = jsonResponse['results'];
      return results
          .map((movieJson) => MovieTopRate.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }
}

class MovieDetailService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '8f6a4a28323848f1c19c2c82cead5d06';

  Future<MovieDetail> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/movie/$movieId?api_key=$_apiKey&append_to_response=videos'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}

class VideoService {
  static const String apiKey =
      '8f6a4a28323848f1c19c2c82cead5d06'; // Replace with your TMDB API key
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  Future<VideoModel> getVideos() async {
    final url = Uri.parse(
        '$_baseUrl/movie/653346/videos?language=en-US&api_key=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        return VideoModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }
}
class SearchService{
   Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=8f6a4a28323848f1c19c2c82cead5d06&query=$query'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final results = jsonResponse['results'] as List;
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
