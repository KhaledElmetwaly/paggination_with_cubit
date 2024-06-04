class MoviesData {
  late final int page, totalPages, totalResults;
  late final List<MovieModel> list;

  MoviesData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    list =
        List.from(json['results']).map((e) => MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieModel {
  late bool adult;
  late String image;
  late List<int> genreIds;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] ?? false;
    image = json['backdrop_path'] == null
        ? "https://cdn-icons-png.flaticon.com/512/138/138574.png?w=1380&t=st=1690228536~exp=1690229136~hmac=fbf4abfcf053d57e98d8bf05e5c74aa3741ff0953f5a8372fd6ea01ad37a2a60"
        : "http://image.tmdb.org/t/p/original${json['backdrop_path']}";
    genreIds = List.castFrom<dynamic, int>(json['genre_ids'] ?? []);
    id = json['id'] ?? 0;
    originalLanguage = json['original_language'] ?? "";
    originalTitle = json['original_title'] ?? "";
    overview = json['overview'] ?? "";
    popularity = double.parse((json['popularity'] ?? 0).toString());
    posterPath = json['poster_path'] == null
        ? "https://cdn-icons-png.flaticon.com/512/138/138574.png?w=1380&t=st=1690228536~exp=1690229136~hmac=fbf4abfcf053d57e98d8bf05e5c74aa3741ff0953f5a8372fd6ea01ad37a2a60"
        : "http://image.tmdb.org/t/p/original${json['poster_path']}";
    releaseDate = json['release_date'] ?? "";
    title = json['title'] ?? "Amr";
    video = json['video'] ?? false;
    voteAverage = double.parse((json['vote_average'] ?? 0).toString());
    voteCount = json['vote_count'] ?? 0;
  }
}
