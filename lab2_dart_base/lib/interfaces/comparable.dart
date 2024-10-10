class Film implements Comparable<Film> {
  String title;
  int year;

  Film(this.title, this.year);

  @override
  int compareTo(Film other) {
    return this.year.compareTo(other.year);
  }

  @override
  String toString() => '$title ($year)';
}
