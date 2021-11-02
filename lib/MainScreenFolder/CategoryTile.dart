import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ListingsFile.dart';

class FoodCategories extends StatefulWidget {
  String ImagePath = "";
  String Caption = "";
  FoodCategories({required this.ImagePath, required this.Caption});
  @override
  _FoodCategoriesState createState() =>
      _FoodCategoriesState(ImagePath: ImagePath, Caption: Caption);
}

class _FoodCategoriesState extends State<FoodCategories> {
  String ImagePath = "";
  String Caption = "";
  _FoodCategoriesState({required this.ImagePath, required this.Caption});
  @override

  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      height:h1/7,
      width: 2*w1/5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black, // red as border color
          width: 2,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit:BoxFit.contain,
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
