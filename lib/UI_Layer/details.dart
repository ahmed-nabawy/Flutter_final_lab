import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfinallab/BLOC_Layer/movieBlocProvider.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<MovieBLOCProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Details(),
    );
  }
}

class Details extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        return Scaffold(
//          backgroundColor: Colors.cyan,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey,
                  Colors.black26,
                  Colors.blueGrey,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: InkWell(
                        child: Hero(
                          tag: movie.clickedMovie.id,
                          child: Image(
                            image: NetworkImage(movie.imageURL + movie.clickedMovie.posterPath),
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  TitleAverageRow(),
                  GenersAdultsRate(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      movie.clickedMovie.overview,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GenersAdultsRate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 20,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.clickedMovie.genres.length,
                  itemBuilder: (_, i) {
                    return Text(
                      movie.clickedMovie.genres[i].name + ', ',
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Adults only: ${movie.clickedMovie.adult}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black26,
                  ),
                ),
                RatingButton(),
              ],
            ),
          ],
        );
      }
    );
  }
}

class RatingButton extends StatefulWidget {
  @override
  _RatingButtonState createState() => _RatingButtonState();
}

class _RatingButtonState extends State<RatingButton> {
  bool _rate = false;
  double _size = 20;
  Color _color = Colors.black26;
  IconData _icon = Icons.star_border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
//        color: Colors.black,
        child: Icon(
          _icon,
          color: _color,
          size: _size,
          key: ValueKey<double>(_size),
        ),
      ),
      onTap: () {
        setState(() {
          if (_rate) {
            _size = 20;
            _color = Colors.black26;
            _icon = Icons.star_border;
          }
          else {
            _icon = Icons.star;
            _color = Colors.yellow;
            _size = 30;
          }
          _rate = !_rate;
        });
      },
    );
  }
}

class TitleAverageRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieBLOCProvider>(
      builder: (context, movie, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  movie.clickedMovie.title,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${movie.clickedMovie.voteAverage}',
                style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}