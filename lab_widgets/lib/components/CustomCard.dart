import 'package:flutter/material.dart';
import 'package:lab_widgets/ProductPage.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  CustomCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 165,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            // GestureDetector для изображения
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductPage(
                      imageUrl: imageUrl,
                      title: title,
                      description: description,
                      review: "Review description"
                  )),
                );
              },
              child: Image.asset(
                imageUrl,
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Positioned elements over the image
            Positioned(
              top: 10.0,
              right: 10.0,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    // Handle heart icon press
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title text
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  // Description text
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
