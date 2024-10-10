import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Заголовок Categories
        Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Color(0xFF2C3E50),
          ),
        ),
        // Текст-ссылка See all
        GestureDetector(
          onTap: () {
            // Логика для перехода при клике на "See all"
            print('See all tapped');
          },
          child: Text(
            'See all',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.orange,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
