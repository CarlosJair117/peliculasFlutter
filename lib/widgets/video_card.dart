import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class PlayerVideo extends StatelessWidget {

  final int movieId;

  const PlayerVideo( this.movieId );

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getVideoKey(movieId),
      builder: ( _, AsyncSnapshot<List<Results>> snapshot) {
        
        if( !snapshot.hasData ) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Results> results = snapshot.data!;

        return Container(
          margin: EdgeInsets.only( bottom: 30 ),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ( _, int index) => _WidowVideo( results[index] ),
          ),
        );

      },
    );

    
  }
}

class _WidowVideo extends StatelessWidget {

  final Results url;

  const _WidowVideo( this.url );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage( url.key ),
              height: 120,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}