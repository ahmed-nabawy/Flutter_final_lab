import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfinallab/BLOC_Layer/movieBlocProvider.dart';
import 'package:flutterfinallab/Model/single_movie.dart';
import 'package:flutterfinallab/UI_Layer/favourites.dart';
import 'package:provider/provider.dart';
import 'details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieBLOCProvider>(
      create: (_) => MovieBLOCProvider(),
      child: MaterialApp(
        home: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              appBar: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Movies',
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favourites',
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              body: TabBarView(
                children: <Widget>[
                  MovieList(),
                  Favourits(),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatefulWidget {

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  @override
  void initState() {
    super.initState();
    Provider.of<MovieBLOCProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        if (movie.list.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        else {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: movie.list.length,
            itemBuilder: (BuildContext _context, int i) {
              return MovieRow(i);
            },
          );
        }
      },
    );
  }
}

class MovieRow extends StatelessWidget {

  final int rowNum;

  MovieRow(this.rowNum);

//  @override
  Widget build(BuildContext context) {
    timeDilation = 3.0;
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: SizedBox(
                      height: 90,
                      child: InkWell(
                        child: Hero(
                          tag: movie.list[rowNum].id,
                          child: Image(
                            image: NetworkImage(movie.imageURL + movie.list[rowNum].posterPath),
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          movie.clickedMovie = movie.list[rowNum];
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return Details();
                          }));
                        },
                      ),
                    ),
                  ),
                  MovieDetails(movie.list[rowNum])
                ]
              ),
            )
          ]
        );
      },
    );
  }
}

class MovieDetails extends StatelessWidget {

  SingleMovieModel movie;
  MovieDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          movie.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Released on : ${movie.release_date}',
        ),
        Container(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: movie.genres.length,
            itemBuilder: (BuildContext _context, int i) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black26
                    ),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    movie.genres[i].name,
                    style: TextStyle(
                        color: Colors.black26
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        IconStatefulWidget(movie),
    Divider(),
    ]
    );
    }
  }

class IconStatefulWidget extends StatefulWidget {
  final SingleMovieModel movie;
  bool liked = false;
  IconStatefulWidget(this.movie);
  @override
  _IconStatefulWidgetState createState() => _IconStatefulWidgetState();
}

class _IconStatefulWidgetState extends State<IconStatefulWidget> {
  bool liked;

  @override
  void initState() {
    super.initState();
    if (Provider.of<MovieBLOCProvider>(context, listen: false).favourits.contains(widget.movie)) {
      liked = true;
    }
    else {
      liked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
      return Consumer<MovieBLOCProvider>(
        builder: (context, movie, _) {
          return InkWell(
            child: Icon(
              liked ? Icons.favorite : Icons.favorite_border,
              color: liked ? Colors.red : null,
            ),
            onTap: () {
              setState(() {
                liked = !liked;
                if (liked) {
                  movie.favourits.add(widget.movie);
                }
                else {
                  movie.favourits.remove(widget.movie);
                }
              });
            },
          );
        },
      );
  }
}