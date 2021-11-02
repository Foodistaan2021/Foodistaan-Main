// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodistan/widgets/options.dart';

class RestaurantMain extends StatefulWidget {
  var restaurant_details;
  RestaurantMain({required this.restaurant_details});

  @override
  _RestaurantMainState createState() => _RestaurantMainState();
}

class _RestaurantMainState extends State<RestaurantMain> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.2,
      ),
      width: MediaQuery.of(context).size.width * 0.97,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.restaurant_details['Name']}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "${widget.restaurant_details['Cuisines']}",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    Text(
                      "${widget.restaurant_details['Address']}",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      onPressed: null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.restaurant_details['Stars']}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "10+ Ratings",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.attach_money,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Cost for Two ${widget.restaurant_details['Cost']}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         maxRadius: 10,
                //         backgroundColor: Colors.blue,
                //         child: Icon(
                //           Icons.bike_scooter,
                //           size: 12,
                //           color: Colors.white,
                //         ),
                //       ),
                //       widget.restaurant_details['delivery'] == true
                //           ? Text(
                //               "Delivery Available",
                //               style: TextStyle(
                //                   color: Colors.grey, fontSize: 10),
                //             )
                //           : Text(
                //               "Delivery Not Available",
                //               style: TextStyle(
                //                   color: Colors.grey, fontSize: 10),
                //             )
                //     ],
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.table_chart,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Seating Available",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height * 0.07,
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected == true ? Colors.amber[400] : Colors.white,
                      border: isSelected == true
                          ? Border.all(color: Colors.amber, width: 1)
                          : Border.all(color: Colors.white, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bike_scooter,
                          size: 15,
                          color: Colors.grey,
                        ),
                        widget.restaurant_details["Delivery"] == true
                            ? Text(
                                " Delivery",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                            : Text(
                                " No Delivery",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected == true ? Colors.amber[400] : Colors.white,
                      border: isSelected == true
                          ? Border.all(color: Colors.amber, width: 1)
                          : Border.all(color: Colors.white, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.food_bank,
                          size: 15,
                          color: Colors.grey,
                        ),
                        widget.restaurant_details["Takeaway"]
                            ? Text(
                                " Pickup",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected == true ? Colors.amber[400] : Colors.white,
                      border: isSelected == true
                          ? Border.all(color: Colors.amber, width: 1)
                          : Border.all(color: Colors.white, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_outlined,
                          size: 15,
                          color: Colors.grey,
                        ),
                        Text(
                          " Overview",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.only(top: 10),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              children: [
                MyOptionListView(
                    iconColor: Colors.green,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
                MyOptionListView(
                    iconColor: Colors.pink,
                    myIcon: Icons.wash,
                    myText: "Washing hands at all times"),
                MyOptionListView(
                    iconColor: Colors.red,
                    myIcon: Icons.thermostat,
                    myText: "Temperature measured"),
                MyOptionListView(
                    iconColor: Colors.blue,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
                MyOptionListView(
                    iconColor: Colors.orange,
                    myIcon: Icons.masks,
                    myText: "Wearing mask at all time"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "OFFER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20% OFF UPTO ₹300",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              "OFFER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "20% OFF UPTO ₹300",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          )
                        ]),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
