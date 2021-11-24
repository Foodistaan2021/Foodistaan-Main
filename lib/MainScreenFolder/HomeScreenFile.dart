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
  bool selectStreetStyle=true;
  bool selectTiffinServices=false;
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
                    EdgeInsets.fromLTRB(w1 / 16, h1 / 70, w1 / 70, h1 / 25),
                child: GestureDetector(
                  onTap: () async {
                    await fetchData('DummyData');
                    selectStreetStyle=true;
                    selectTiffinServices=false;
                    setState(() {});
                  },
                  child: FoodCategories(
                      ImagePath: 'Images/food-trolley.png',
                      Caption: 'Street Style',
                      isSelected:selectStreetStyle,),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(w1 / 16, h1 / 70, w1 / 70, h1 / 25),
                child: GestureDetector(
                  onTap: () async {
                    await fetchData('TiffinServices');
                    selectStreetStyle=false;
                    selectTiffinServices=true;
                    setState(() {});

                  },
                  child: FoodCategories(
                      ImagePath: 'Images/tiffin.png',
                      Caption: 'Tiffin Services',
                  isSelected:selectTiffinServices ,),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(w1 / 20, 0,0,0),
              child:RichText(
                text:  TextSpan(
                  text: "Order by ",
                  style: TextStyle(
                             color: Color(0xFF0F1B2B),
                            fontSize: h1 / 30,) ,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Cuisines',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        color: Color(0xFF0F1B2B),
                      ),
                    ),
                  ],
                ),
              )
              // child: Text("Order by Cuisines",
              //     children:,
              //     style: TextStyle(
              //         color: Color(0xFF0F1B2B),
              //         fontSize: h1 / 25,
              //         fontWeight: FontWeight.bold)),
            ),
          ),
          CuisineTileList(),
          Listings(),
        ],
      ),
    );
  }
}
