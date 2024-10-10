import 'package:flutter/material.dart';


class ImageWithText extends StatelessWidget {
  final String imagePath;
  final String text;

  ImageWithText({
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0), // Закругленные края
          child: Image.asset(
            imagePath,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.0,
            color: Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }
}
