import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/card_swiper.dart';
//import 'package:peliculas/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class DemasPelis extends StatefulWidget {
  const DemasPelis({key});

  @override
  State<DemasPelis> createState() => _DemasPelisState();
}

class _DemasPelisState extends State<DemasPelis> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Container( 
      child:SingleChildScrollView(
        child: Column(
          children: [
            Text('Proximamente', style: TextStyle(fontSize: 28),),
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.topRatedMovies ),

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