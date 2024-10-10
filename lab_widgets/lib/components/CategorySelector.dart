import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 1; // Active button (for example, 'Popular')

  final List<String> categories = ['All', 'Popular', 'Recommended', 'More'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.red : Colors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
