class Director {
  String _name;
  int _experience;

  static int directorCount = 0;

  Director(this._name, this._experience) {
    directorCount++;
  }

  Director.withName(this._name) : _experience = 0 {
    directorCount++;
  }

  String get name => _name;
  set name(String name) => _name = name;

  int get experience => _experience;
  set experience(int years) {
    if (years >= 0) {
      _experience = years;
    } else {
      print('Опыт не может быть отрицательным.');
    }
  }

  void direct({String? genre}) {
    print('Режиссёр $_name снимает фильм ${genre ?? ''}.');
  }

  static void showDirectorCount() {
    print('Количество директоров: $directorCount');
  }
}
