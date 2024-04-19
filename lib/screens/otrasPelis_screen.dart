import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/card_swiper.dart';
//import 'package:peliculas/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class OtrasPelis extends StatefulWidget {
  const OtrasPelis({key});

  @override
  State<OtrasPelis> createState() => _OtrasPelisState();
}

class _OtrasPelisState extends State<OtrasPelis> {
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Container( 
      child:SingleChildScrollView(
        child: Column(
          children: [
            Text('En Cartelera', style: TextStyle(fontSize: 28),),
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            // Slider de películas
            // MovieSlider(
            //   movies: moviesProvider.popularMovies,// populares,
            //   title: 'Populares', // opcional
            //   onNextPage: () => moviesProvider.getPopularMovies(),
            // ),
            
          ],
        ),
      ) ,
    );
  }
}