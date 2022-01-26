import 'package:flutter/material.dart';

import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/restuarant_screens/testRestaurant_main.dart';

import 'package:foodistan/widgets/total_bill_bottam_widget.dart';

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
                        onTap: () {
                          // print(widget.vendorName);
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 25,
                        ),
                      )),
                ]),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                            // child: RestaurantMain(
                            //   restaurant_details: widget.items,
                            // ),

                            // For testing
                            child: TestRestaurantMain(
                                restaurant_details: widget.items,
                                vendorId: widget.vendor_id,
                                vendorName: widget.vendorName),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TotalBillBottomWidget()),
            ],
          )),
    );
  }
}
