import 'package:flutter/material.dart';
import '../Models/film_model.dart';

class FilmDetailsScreen extends StatefulWidget {
  final Film? film;
  final Function(Film) onSave;

  FilmDetailsScreen({required this.film, required this.onSave});

  @override
  _FilmDetailsScreenState createState() => _FilmDetailsScreenState();
}

class _FilmDetailsScreenState extends State<FilmDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _directorController;
  late TextEditingController _releaseYearController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.film?.title ?? '');
    _directorController = TextEditingController(text: widget.film?.director ?? '');
    _releaseYearController = TextEditingController(text: widget.film?.releaseYear.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.film?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _directorController.dispose();
    _releaseYearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveFilm() {
    try {
      final releaseYear = int.parse(_releaseYearController.text);
      final film = Film(
        id: widget.film?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        director: _directorController.text,
        releaseYear: releaseYear,
        description: _descriptionController.text,
      );
      widget.onSave(film);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: некорректный год выпуска")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film == null ? "Add Film" : "Edit Film"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _directorController,
              decoration: InputDecoration(labelText: "Director"),
            ),
            TextField(
              controller: _releaseYearController,
              decoration: InputDecoration(labelText: "Release Year"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveFilm();
              },
              child: Text(widget.film == null ? "Add Film" : "Update Film"),
            ),
          ],
        ),
      ),
    );
  }
}
