import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/widgets/bottom_navbar.dart';

class RestaurantDelivery extends StatefulWidget {
  static String id = 'restaurant_delivery';
  var items;
  String vendor_id, vendorName;
  RestaurantDelivery(
      {required this.items, required this.vendor_id, required this.vendorName});

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

    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.green,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1 item | Rs 110",
                          style: TextStyle(color: Colors.white)),
                      Text("Extra charges may apply",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: GestureDetector(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (c) => CartScreenMainLogin()));
                      },
                      child: Text("VIEW BILL",
                          style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          ),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
            child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                actions: <Widget>[
                  Container(
                      padding: EdgeInsets.all(7.5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 25,
                        ),
                      )),
                ]),
          ),
          body: SizedBox(
              child: ListView(
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Container(
                      padding: EdgeInsets.all(11),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          '${widget.items['FoodImage']}',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(11),
                    child: Center(
                      child: RestaurantMain(
                        restaurant_details: widget.items,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Center(
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
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
                height: 11,
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
                              margin: EdgeInsets.only(left: 11),
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
                                                    TextDecoration.underline)
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
                                                    TextDecoration.underline)
                                            : TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: DropdownButton(
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Top Rated",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        items: ['Top Rated', 'Oldest', 'Latest']
                                            .map(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              value: val,
                                              child: Text(val),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                          // selectcountry = val;
                                          // onSubmit check
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 15),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: isReviewSelected
                                    ? RestuarantDeliveryReview()
                                    : RestuarantDeliveryMenu(
                                        vendor_id: widget.vendor_id,
                                        vendorName: widget.vendorName)),
                          ],
                        )))
                    : RestaurantOverview(),
              )
            ],
          ))),
    );
  }
}
