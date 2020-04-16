import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfinallab/BLOC_Layer/movieBlocProvider.dart';
import 'package:flutterfinallab/Model/single_movie.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class Favourits extends StatefulWidget {

  @override
  _Favourits createState() => _Favourits();
}

class _Favourits extends State<Favourits> {

  @override
  void initState() {
    super.initState();
    Provider.of<MovieBLOCProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        if (movie.favourits.isEmpty) {
          return Center(
            child: Text(
              'There is no favourits.',
            ),
          );
        }
        else {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: movie.favourits.length,
            itemBuilder: (BuildContext _context, int i) {
              return FavouritsRow(i);
            },
          );
        }
      },
    );
  }
}

class FavouritsRow extends StatefulWidget {

  final int rowNum;

  FavouritsRow(this.rowNum);

  @override
  _FavouritsRowState createState() => _FavouritsRowState();
}

class _FavouritsRowState extends State<FavouritsRow> {
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
                              tag: movie.favourits.elementAt(widget.rowNum).id,
                              child: Image(
                                image: NetworkImage(movie.imageURL + movie.favourits.elementAt(widget.rowNum).posterPath),
                                fit: BoxFit.fill,
                              ),
                            ),
                            onTap: () {
                              movie.clickedMovie = movie.favourits.elementAt(widget.rowNum);
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                return Details();
                              }));
                            },
                          ),
                        ),
                      ),
                      FavouritDetails(movie.favourits.elementAt(widget.rowNum)),
                    ]
                ),
              )
            ]
        );
      },
    );
  }
}

class FavouritDetails extends StatefulWidget {

  SingleMovieModel movie;
  FavouritDetails(this.movie);

  @override
  _FavouritDetailsState createState() => _FavouritDetailsState();
}

class _FavouritDetailsState extends State<FavouritDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.movie.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Released on : ${widget.movie.release_date}',
          ),
          Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: widget.movie.genres.length,
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
                      widget.movie.genres[i].name,
                      style: TextStyle(
                          color: Colors.black26
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ]
    );
  }
}