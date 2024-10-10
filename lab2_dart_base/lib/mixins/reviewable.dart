mixin Reviewable {
  List<String> reviews = [];

  void addReview(String review) {
    reviews.add(review);
  }

  void showReviews() {
    if (reviews.isNotEmpty) {
      print('Отзывы:');
      for (var review in reviews) {
        print('- $review');
      }
    } else {
      print('Отзывов пока нет.');
    }
  }
}
