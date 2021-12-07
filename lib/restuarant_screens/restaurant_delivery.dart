import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/widgets/bottom_navbar.dart';

class RestaurantDelivery extends StatefulWidget {
  static String id = 'restaurant_delivery';
  var items;
  String vendor_id,vendorName;
  RestaurantDelivery({required this.items, required this.vendor_id,required this.vendorName});

  @override
  _RestaurantDeliveryState createState() => _RestaurantDeliveryState();
}

class _RestaurantDeliveryState extends State<RestaurantDelivery> {
  bool isMenuSelected = true;
  bool isReviewSelected = false;
  bool isCartEmpty = true;
  bool isDeliverySelected = false;
  bool isOverviewSelected = false;

  @override
  void initState() {
    super.initState();
    isDeliverySelected = true;
  }

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
        bottomNavigationBar:
            Visibility(visible: isCartEmpty, child: BottomNavBar()),
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
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        '${widget.items['FoodImage']}',
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  child: Center(
                    child: RestaurantMain(
                      restaurant_details: widget.items,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
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
            SizedBox(
              height: 500,
              child: isDeliverySelected == true
                  ? Container(
                      margin: EdgeInsets.only(top: 15),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                          child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("Menu selected");
                                      setState(() {
                                        isReviewSelected = false;
                                        isMenuSelected = true;
                                      });
                                    },
                                    child: Text(
                                      "Menu",
                                      style: isMenuSelected == true
                                          ? TextStyle(
                                              fontSize: 16,
                                              color: Colors.amber,
                                              fontWeight: FontWeight.w700,
                                              decoration:
                                                  TextDecoration.overline)
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
                                      setState(() {
                                        isReviewSelected = true;
                                        isMenuSelected = false;
                                      });
                                    },
                                    child: Text(
                                      "Reviews",
                                      style: isReviewSelected == true
                                          ? TextStyle(
                                              fontSize: 16,
                                              color: Colors.amber,
                                              fontWeight: FontWeight.w700,
                                              decoration:
                                                  TextDecoration.overline)
                                          : TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: isReviewSelected
                                  ? RestuarantDeliveryReview()
                                  : RestuarantDeliveryMenu(
                                      vendor_id: widget.vendor_id,
                                      vendorName : widget.vendorName
                                    )),
                        ],
                      )))
                  : RestaurantOverview(),
            )
          ],
        )));
  }
}
