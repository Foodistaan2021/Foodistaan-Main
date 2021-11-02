import 'package:flutter/material.dart';

class CuisineTileList extends StatelessWidget {

  List CuisineTiles=[
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFF03636),BgColor: const Color(0xFFFFE7E7),),
    Cuisines(Text1: "Fusion", Text2: "FRIES", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFFFE800),BgColor: const Color(0xFFFFFCDE)),
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFA0FF00),BgColor: const Color(0xFFEFFFD4)),
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFF00CCFF),BgColor: const Color(0xFFE9F9FD)),
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFF03636),BgColor: const Color(0xFFFFE7E7),),
    Cuisines(Text1: "Fusion", Text2: "FRIES", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFFFE800),BgColor: const Color(0xFFFFFCDE)),
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFFA0FF00),BgColor: const Color(0xFFEFFFD4)),
    Cuisines(Text1: "Burger", Text2: "BOMB", FoodImage: 'Images/burger.png',BorderColor: const Color(0xFF00CCFF),BgColor: const Color(0xFFE9F9FD)),

  ];

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      height: h1 / 6,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: CuisineTiles.length,
        itemBuilder: (context, index) {
          final item= CuisineTiles[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(w1 / 50, h1 / 50, w1 / 70, h1 / 50),
            child:  item
          );
        },
      ),
    );
  }
}

class Cuisines extends StatelessWidget {
  String Text1 = "";
  String Text2 = "";
  String FoodImage = "";
  Color BgColor;
  Color BorderColor;


  Cuisines(
      {required this.Text1,
      required this.Text2,
      required this.FoodImage,
      required this.BorderColor,
      required this.BgColor,
      });

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      //height:85,
      //height: h1/12,
      width: w1/5,
      decoration: BoxDecoration(
          color: BgColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: BorderColor, // red as border color
            width: 2,
          )),
      child: GestureDetector(
        onTap: () {},
        child: FittedBox(
          fit:BoxFit.contain,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Text1,
                style: TextStyle(
                  color: Colors.black,
                   fontSize: 15),
                textAlign: TextAlign.left,
              ),
              Text(Text2,
                  style: TextStyle(
                      color: BorderColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.left),
              Image.asset(FoodImage),
            ],
          ),
        ),
      ),
    );
  }
}
