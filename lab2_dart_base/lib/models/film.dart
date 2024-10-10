import 'dart:convert';
import 'dart:async';

// Абстрактный класс Film
abstract class Film implements Comparable<Film> {
  String title;
  int year;
  List<String> reviews = [];

  Film(this.title, this.year);

  void play();

  // Добавление и показ отзывов
  void addReview(String review) {
    reviews.add(review);
  }

  void showReviews() {
    if (reviews.isNotEmpty) {
      print('Отзывы о фильме $title:');
      for (var review in reviews) {
        print('- $review');
      }
    } else {
      print('Отзывов о фильме $title пока нет.');
    }
  }

  // Метод для сериализации, который будет переопределен в подклассах
  Map<String, dynamic> toJson();

  // Метод для десериализации, который создает объект на основе типа фильма
  static Film fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'action':
        return ActionFilm.fromJson(json);
      case 'drama':
        return DramaFilm.fromJson(json);
      default:
        throw Exception('Неизвестный тип фильма');
    }
  }

  // Реализация интерфейса Comparable для сравнения фильмов по году
  @override
  int compareTo(Film other) {
    return year.compareTo(other.year);
  }
}

// Абстрактная фабрика для создания фильмов
abstract class FilmFactory {
  Film createFilm();
}

// Класс боевого фильма
class ActionFilm extends Film {
  ActionFilm(String title, int year) : super(title, year);

  @override
  void play() {
    print('Воспроизведение боевого фильма: $title ($year).');
  }

  @override
  Map<String, dynamic> toJson() => {
    'type': 'action',
    'title': title,
    'year': year,
  };

  static ActionFilm fromJson(Map<String, dynamic> json) {
    return ActionFilm(json['title'], json['year']);
  }
}

// Класс драматического фильма
class DramaFilm extends Film {
  DramaFilm(String title, int year) : super(title, year);

  @override
  void play() {
    print('Воспроизведение драматического фильма: $title ($year).');
  }

  @override
  Map<String, dynamic> toJson() => {
    'type': 'drama',
    'title': title,
    'year': year,
  };

  static DramaFilm fromJson(Map<String, dynamic> json) {
    return DramaFilm(json['title'], json['year']);
  }
}

// Фабрики для боевых и драматических фильмов
class ActionFilmFactory extends FilmFactory {
  @override
  Film createFilm() {
    return ActionFilm('Default Action Title', 2024);
  }
}

class DramaFilmFactory extends FilmFactory {
  @override
  Film createFilm() {
    return DramaFilm('Default Drama Title', 2024);
  }
}

// Асинхронная функция
Future<void> asyncMethod() async {
  print('Выполняется асинхронная операция...');
  await Future.delayed(Duration(seconds: 2));
  print('Асинхронная операция завершена.');
}

// Пример работы с Future
Future<String> fetchFilmTitle() async {
  await Future.delayed(Duration(seconds: 1)); // эмуляция задержки
  return 'Inception';
}

void futureDemo() {
  fetchFilmTitle().then((title) {
    print('Название фильма: $title');
  }).catchError((error) {
    print('Ошибка: $error');
  });
}

// Функция для сериализации и десериализации фильма
void jsonSerializationDemo() {
  // Создаем фильм
  FilmFactory actionFilmFactory = ActionFilmFactory();
  Film actionFilm = actionFilmFactory.createFilm()
    ..title = 'Mad Max'
    ..year = 2015;

  // Сериализуем фильм в JSON
  String jsonStr = jsonEncode(actionFilm.toJson());
  print('Сериализованный фильм: $jsonStr');

  // Десериализуем фильм из JSON
  Film deserializedFilm = Film.fromJson(jsonDecode(jsonStr));
  print('Десериализованный фильм: ${deserializedFilm.title} (${deserializedFilm.year})');
}