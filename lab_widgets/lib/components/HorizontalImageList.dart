import 'package:flutter/material.dart';

import 'ImageWithText.dart';



class HorizontalImageList extends StatelessWidget {
  final List<Map<String, String>> items;

  HorizontalImageList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0, // Высота для контейнера (по желанию)
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Горизонтальная прокрутка
        itemCount: items.length, // Количество элементов
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Отступы между элементами
            child: ImageWithText(
              imagePath: item['imagePath']!, // Путь к изображению
              text: item['text']!, // Текст под изображением
            ),
          );
        },
      ),
    );
  }
}

