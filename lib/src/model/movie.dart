class Movie {
  final int id; // Add the id attribute
  final String title;
  final String overview;
  final String posterPath;
  final double voteAverage;

  Movie({
    required this.id, // Add the id parameter
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'], // Parse the id from JSON
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include the id in the JSON map
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'vote_average': voteAverage,
    };
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class MovieTopRate {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieTopRate({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieTopRate.fromJson(Map<String, dynamic> json) {
    return MovieTopRate(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  @override
  String toString() {
    return 'Movie{title: $title, releaseDate: $releaseDate, voteAverage: $voteAverage}';
  }
}

class MovieDetail {
  final String title;
  final String overview;
  final String releaseDate;
  final int runtime;
  final List<String> genres;
  final double voteAverage;
  final String posterPath;
  final String tagline;
  final List<Video> videos;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    required this.voteAverage,
    required this.posterPath,
    required this.tagline,
    required this.videos,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
      tagline: json['tagline'] ?? '',
      videos: (json['videos']['results'] as List)
          .map((video) => Video.fromJson(video))
          .toList(),
    );
  }
}

class Video {
  final String key;
  final String type;

  Video({required this.key, required this.type});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      key: json['key'],
      type: json['type'],
    );
  }
}
class VideoModel {
  int? id;
  List<Results>? results;

  VideoModel({this.id, this.results});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Results(
      {this.iso6391,
      this.iso31661,
      this.name,
      this.key,
      this.site,
      this.size,
      this.type,
      this.official,
      this.publishedAt,
      this.id});

  Results.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    data['key'] = this.key;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    data['official'] = this.official;
    data['published_at'] = this.publishedAt;
    data['id'] = this.id;
    return data;
  }
}