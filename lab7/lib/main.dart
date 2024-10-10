import 'package:flutter/material.dart';

import 'Screens/film_list_screen.dart';

void main() {
  runApp(FilmApp());
}

class FilmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilmListScreen(),
    );
  }
}
