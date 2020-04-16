import 'package:flutter/material.dart';
import 'package:flutterfinallab/Data_Access_Layer/repository.dart';
import 'package:flutterfinallab/Model/single_movie.dart';

class MovieBLOCProvider extends ChangeNotifier{

  List<SingleMovieModel> list = <SingleMovieModel>[];
  String imageURL = 'https://image.tmdb.org/t/p/w500';
  SingleMovieModel clickedMovie;
  Set<SingleMovieModel> favourits = Set<SingleMovieModel>();
//  Future<MoviesListModel> getOne(int loc) async {
//    List<MoviesListModel> list = await MovieRepository().list();
//    return list[loc];
//  }
  MovieBLOCProvider() {
    getAll();
  }

  void getAll() async {
    list = await MovieRepository().list();
    notifyListeners();
  }
}