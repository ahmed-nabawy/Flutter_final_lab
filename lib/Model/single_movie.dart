class SingleMovieModel {
  bool adult;
  List<Genres> genres;
  int id;
  String overview;
  String posterPath;
  String title;
  double voteAverage;
  String release_date;

  SingleMovieModel({this.adult,
    this.genres,
    this.id,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.release_date});

  SingleMovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    id = json['id'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    title = json['title'];
    voteAverage = json['vote_average'] * 1.0;
    release_date = json['release_date'];
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}