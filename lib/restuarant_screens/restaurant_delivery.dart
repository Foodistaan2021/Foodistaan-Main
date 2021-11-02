// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/widgets/bottom_navbar.dart';


class RestaurantDelivery extends StatefulWidget {
  static String id = 'restaurant_delivery';
  var items;
  String vendor_id;
  RestaurantDelivery({required this.items, required this.vendor_id});

  @override
  _RestaurantDeliveryState createState() => _RestaurantDeliveryState();
}

class _RestaurantDeliveryState extends State<RestaurantDelivery> {
  bool isMenuSelected = true;
  bool isReviewSelected = false;
 
  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 26.0,
                    ),
                  )),
            ]),
      ),
      // bottomNavigationBar: BottomNavBar(),
      body: SizedBox(
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        '${widget.items['FoodImage']}',
                        fit: BoxFit.cover,
                      ),
                    )),
                Center(
                  child: RestaurantMain(
                    restaurant_details: widget.items,
                  ),
                )
              ],
            ),
            Column(children: [
              Container(
                margin: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.search),
                          ),
                          hintText: "Search within the menu",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2.0,
                              )))),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("Menu selected");
                            isReviewSelected = false;
                            isMenuSelected = true;
                          },
                          child: Text(
                            "Menu",
                            style: isMenuSelected == true
                                ? TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)
                                : TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Reviews selected");
                            isReviewSelected = true;
                            isMenuSelected = false;
                          },
                          child: Text(
                            "Reviews",
                            style: isReviewSelected == true
                                ? TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)
                                : TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ]),
                ),
              ),
            ]),
            SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                width: MediaQuery.of(context).size.width * 0.7,
                child: isReviewSelected
                    ? RestuarantDeliveryReview()
                    : RestuarantDeliveryMenu(vendor_id: widget.vendor_id,)),
          ],
        ),
      ),
    );
  }
}
