import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Container( 
      child:SingleChildScrollView(
        child: Column(
          children: [
            Text('Mejor Calificadas', style: TextStyle(fontSize: 28),),
            // Tarjetas principales
            CardSwiper( movies: moviesProvider.popularMovies ),

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