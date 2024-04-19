
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:peliculas/helpers/debouncer.dart';

import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {

  String _apiKey   = '1865f43a0549ca50d341dd9ab8b29f49';
  String _baseUrl  = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> popularMovies   = [];


  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Results>> videoKey = {};
    
  //int _popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ),
  );

  final StreamController<List<Movie>> _suggestionStreamContoller = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamContoller.stream;



  MoviesProvider() {
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();

  }

  Future<String> _getJsonData( String endpoint, [int page = 1] ) async {
    final url = Uri.https( _baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }


  getOnDisplayMovies() async {
    
    final jsonData = await this._getJsonData('3/movie/now_playing', 1);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getTopRatedMovies() async {
    
    final jsonData = await this._getJsonData('3/movie/upcoming', 1);
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
    topRatedMovies = nowPlayingResponse.results;
    
    notifyListeners();
  }

  getPopularMovies() async {


    final jsonData = await this._getJsonData('3/movie/top_rated', 1);
    final popularResponse = PopularResponse.fromJson( jsonData );
    
    popularMovies = popularResponse.results;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async {

    final url = Uri.https( _baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson( response.body );

    return searchResponse.results;
  }


  Future<List<Results>> getVideoKey(int movieId) async {
    if (videoKey.containsKey(movieId)) return videoKey[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/videos');
    final videoResponse = VideoResponse.fromJson(jsonData);

    videoKey[movieId] = videoResponse.results;

    return videoResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamContoller.add( results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }


}