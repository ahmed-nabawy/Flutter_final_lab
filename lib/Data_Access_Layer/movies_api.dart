import 'package:flutterfinallab/Model/movies_list.dart';
import 'package:flutterfinallab/Model/single_movie.dart';

import 'client.dart';

class MovieAPI {
  String url = 'https://api.themoviedb.org/4/discover/movie?api_key=6557d01ac95a807a036e5e9e325bb3f0&sort_by=popularity.desc';
  String movieURL = 'https://api.themoviedb.org/3/movie/', key = '?api_key=6557d01ac95a807a036e5e9e325bb3f0';
  Future<List<SingleMovieModel>> getMovieList() async {
    HTTPClient client = HTTPClient();
    var json = await client.get(url);
    MoviesListModel moviesList = MoviesListModel.fromJson(json);
    List<Results> ids = moviesList.results;
    List<SingleMovieModel> movies = List<SingleMovieModel>();
    for(var id in ids) {
      var movieJSON = await client.get(movieURL + '${id.id}' + key);
      movies.add(SingleMovieModel.fromJson(movieJSON));
    }
    return movies;
  }
}