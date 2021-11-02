import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Crousel.dart';
import 'CategoryTile.dart';
import 'CuisineTile.dart';
import 'ListingsFile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OfferSlider(),
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(w1 / 16, h1 / 70, w1 / 70, h1 / 20),
                child: GestureDetector(
                  onTap: () async {
                    await fetchData();
                    setState(() {});
                  },
                  child: FoodCategories(
                      ImagePath: 'Images/food-trolley.png',
                      Caption: 'Street Style'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(w1 / 16, h1 / 70, w1 / 70, h1 / 20),
                child: GestureDetector(
                  onTap: () async {
                    await fetchData();
                    setState(() {});
                  },
                  child: FoodCategories(
                      ImagePath: 'Images/tiffin.png',
                      Caption: 'Tiffin Services'),
                ),
              )
            ],
          ),
          Text("Order by Cuisine",
              style: TextStyle(
                  color: Color(0xFF0F1B2B),
                  fontSize: h1 / 25,
                  fontWeight: FontWeight.bold)),
          CuisineTileList(),
          Listings(),
        ],
      ),
    );
  }
}
