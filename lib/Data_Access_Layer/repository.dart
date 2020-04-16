import 'package:flutterfinallab/Model/movies_list.dart';
import 'package:flutterfinallab/Model/single_movie.dart';
import 'movies_api.dart';

class MovieRepository {
  Future<List<SingleMovieModel>> list() async => await MovieAPI().getMovieList();
}