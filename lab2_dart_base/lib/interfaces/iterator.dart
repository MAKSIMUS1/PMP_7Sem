import '../models/film.dart';

class FilmCollection extends Iterable<Film> {
  List<Film> films = [];

  @override
  Iterator<Film> get iterator => films.iterator;
}

class FilmIterator implements Iterator<Film> {
  int index = 0;
  List<Film> films;

  FilmIterator(this.films);

  @override
  Film get current => films[index];

  @override
  bool moveNext() {
    index++;
    return index < films.length;
  }
}
