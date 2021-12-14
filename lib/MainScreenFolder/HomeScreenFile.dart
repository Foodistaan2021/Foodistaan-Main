import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Crousel.dart';
import 'CategoryTile.dart';
import 'CuisineTile.dart';
import 'ListingsFile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selectStreetStyle = true;
  bool selectTiffinServices = false;
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OfferSlider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 11,
                    right: 5.5,
                    top: 15,
                    bottom: 15,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await fetchData('DummyData');
                      selectStreetStyle = true;
                      selectTiffinServices = false;
                      setState(() {});
                    },
                    child: FoodCategories(
                      ImagePath: 'Images/food-trolley.svg',
                      Caption: 'Street Style',
                      isSelected: selectStreetStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5.5,
                    right: 11,
                    top: 15,
                    bottom: 15,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await fetchData('TiffinServices');
                      selectStreetStyle = false;
                      selectTiffinServices = true;
                      setState(() {});
                    },
                    child: FoodCategories(
                      ImagePath: 'Images/tiffin.svg',
                      Caption: 'Tiffin Services',
                      isSelected: selectTiffinServices,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 11,
                  left: 11,
                ),
                child: Text(
                  'Order by Cuisines',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: h1 / 33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          CuisineTileList(),
          Listings(),
          SizedBox(
            height: 33,
          ),
        ],
      ),
    );
  }
}
