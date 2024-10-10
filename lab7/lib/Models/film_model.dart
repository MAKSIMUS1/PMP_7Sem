class Film {
  final int id;
  final String title;
  final String director;
  final int releaseYear;
  final String description;

  Film({
    required this.id,
    required this.title,
    required this.director,
    required this.releaseYear,
    required this.description,
  });

  // Преобразование объекта Film в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'releaseYear': releaseYear,
      'description': description,
    };
  }

  // Создание объекта Film из JSON
  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      title: json['title'],
      director: json['director'],
      releaseYear: json['releaseYear'],
      description: json['description'],
    );
  }
}
