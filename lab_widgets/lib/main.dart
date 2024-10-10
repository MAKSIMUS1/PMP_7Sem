import 'package:flutter/material.dart';
import 'package:lab_widgets/components/CategoriesHeader.dart';

import 'components/BottomNavBar.dart';
import 'components/CategorySelector.dart';
import 'components/CustomCard.dart';
import 'components/HorizontalImageList.dart';
import 'components/Search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Установите начальный экран
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Первый экран'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Let's Discover",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  Icon(Icons.person),
                ],
              ),
              MySearchBar(),
              CategoriesHeader(),
              HorizontalImageList(
                items: [
                  {'imagePath': 'assets/images/sample1.jpg', 'text': 'Ocean'},
                  {'imagePath': 'assets/images/sample2.jpg', 'text': 'Mountain'},
                  {'imagePath': 'assets/images/sample3.png', 'text': 'Camp'},
                  {'imagePath': 'assets/images/sample4.png', 'text': 'Forest'},
                ],
              ),
              CategorySelector(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCard(
                    title: 'The Island Shrine Of Itsukushima',
                    description:
                    'It was originally built in 593 by Saeki no Kuramoto. Later, Taira no Kiyomori became heavily involved with the shrine.',
                    imageUrl: 'assets/images/card1.jpg',
                  ),
                  CustomCard(
                    title: 'Osaka Castle',
                    description:
                    'The main keep of Osaka Castle is situated on a plot of land roughly one square kilometre.',
                    imageUrl: 'assets/images/sample2.jpg',
                  ),
                ],
              ),
              BottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}
