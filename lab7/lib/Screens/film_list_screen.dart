import 'package:flutter/material.dart';
import '../Models/film_model.dart';
import '../Repository/film_repository.dart';
import 'film_details_screen.dart';
import 'directory_selection_screen.dart'; // Импортируйте экран выбора директории

class FilmListScreen extends StatefulWidget {
  @override
  _FilmListScreenState createState() => _FilmListScreenState();
}

class _FilmListScreenState extends State<FilmListScreen> {
  final FilmRepository _filmRepository = FilmRepository();
  List<Film> _films = [];
  String? _selectedDirectory; // Переменная для хранения выбранной директории

  @override
  void initState() {
    super.initState();
    _loadFilms();
  }

  Future<void> _loadFilms() async {
    _films = await _filmRepository.getAllFilms();
    setState(() {});
  }

  void _navigateToAddFilm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilmDetailsScreen(
          film: null,
          onSave: (Film film) async {
            await _filmRepository.addFilm(film);
            _loadFilms();  // Обновляем список после добавления
          },
        ),
      ),
    );
  }

  void _deleteFilm(int id) async {
    await _filmRepository.deleteFilm(id);
    _loadFilms();
  }

  void _selectDirectory() async {
    final selectedDir = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DirectorySelectionScreen(selectedDirectory: _selectedDirectory),
      ),
    );

    if (selectedDir != null) {
      setState(() {
        _selectedDirectory = selectedDir;
        _filmRepository.setDatabasePath(_selectedDirectory!);
      });
      _loadFilms();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Films List"),
        actions: [
          IconButton(
            icon: Icon(Icons.folder), // Иконка для выбора директории
            onPressed: _selectDirectory,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddFilm,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _films.length,
        itemBuilder: (context, index) {
          final film = _films[index];
          return Dismissible(
            key: Key(film.id.toString()),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              _deleteFilm(film.id);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Film deleted")));
            },
            child: ListTile(
              title: Text(film.title),
              subtitle: Text("Directed by ${film.director}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilmDetailsScreen(
                      film: film,
                      onSave: (Film updatedFilm) async {
                        await _filmRepository.updateFilm(updatedFilm);
                        _loadFilms();  // Обновляем список после обновления
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
