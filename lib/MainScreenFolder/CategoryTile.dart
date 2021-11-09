import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FoodCategories extends StatelessWidget {
  String ImagePath = "";
  String Caption = "";
  bool isSelected;
  FoodCategories({
    required this.ImagePath,
    required this.Caption,
    this.isSelected = true,
  });
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      height: h1 / 7,
      width: 2 * w1 / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? Color(0xffFAB84C)
              : Colors.black, // red as border color
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            children: [
              Image(image: AssetImage(ImagePath)),
              Text(
                Caption,
                style: TextStyle(color: Color(0xFF1E2019)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
