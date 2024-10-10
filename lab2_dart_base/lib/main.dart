import 'dart:convert';
import 'dart:async';
import 'models/film.dart';
import 'models/director.dart';
import 'models/genre.dart';
import 'utils/collections.dart';
import 'utils/loops.dart';
import 'utils/exceptions.dart';

void main() {
  // Создание фабрик для фильмов
  FilmFactory actionFilmFactory = ActionFilmFactory();
  FilmFactory dramaFilmFactory = DramaFilmFactory();

  print('--- Демонстрация mixins ---');
  // Используем фабрику для создания экземпляра боевого фильма
  Film actionFilm = actionFilmFactory.createFilm()
    ..title = 'Mad Max'
    ..year = 2015;
  actionFilm.addReview('Отличный фильм!');
  actionFilm.showReviews();

  print('\n--- Демонстрация работы с Comparable ---');
  // Создание двух фильмов через фабрики
  Film film1 = actionFilmFactory.createFilm()
    ..title = 'Inception'
    ..year = 2010;
  Film film2 = dramaFilmFactory.createFilm()
    ..title = 'Avatar'
    ..year = 2009;

  // Сравнение двух фильмов по году выпуска
  print(film1.compareTo(film2) > 0 ? '${film1.title} новее' : '${film2.title} новее');

  print('\n--- Сериализация в JSON ---');
  jsonSerializationDemo();

  print('\n--- Асинхронный метод ---');
  asyncMethod();

  print('\n--- Работа с Future ---');
  futureDemo();

  print('\n--- Работа с Stream ---');
  streamDemo();
}
