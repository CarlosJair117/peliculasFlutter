import 'package:flutter/material.dart';
import 'package:peliculas/screens/demasPelis_screen.dart';
import 'package:peliculas/screens/otrasPelis_screen.dart';
import 'package:peliculas/screens/principal_screen.dart';

import 'package:peliculas/search/search_delegate.dart';


class HomeScreen extends StatefulWidget {

  
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [const PrincipalScreen(), OtrasPelis(), DemasPelis() ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon( Icons.search_outlined ),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate() ),
          )
        ],
      ),
      body: screens[selectedIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_rounded),
            label: 'Top Rated',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'En Cartelera',
            backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Upcoming',
            backgroundColor: Colors.red,
          ),
        ],
        backgroundColor: Colors.amber,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        ),
    );
  }
}