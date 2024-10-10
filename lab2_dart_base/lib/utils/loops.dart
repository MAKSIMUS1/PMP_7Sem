void loopDemo() {
  List<String> films = ['Индиана Джонс', 'Темный рыцарь', 'Начало'];
  for (var film in films) {
    if (film == 'Начало') {
      continue;
    }
    if (film == 'Темный рыцарь') {
      break;
    }
    print(film);
  }
}
