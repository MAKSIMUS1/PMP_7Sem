import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Цвет фона
        borderRadius: BorderRadius.circular(30.0), // Закругление по бокам
      ),
      child: Row(
        children: [
          Icon(
            Icons.search, // Иконка лупы
            color: Colors.black,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search destination', // Текст на заднем фоне
                border: InputBorder.none, // Убираем стандартную границу
              ),
            ),
          ),
        ],
      ),
    );
  }
}
