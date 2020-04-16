class MoviesListModel {
  List<Results> results;

  MoviesListModel({this.results});

  MoviesListModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  int id;

  Results({this.id,});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}