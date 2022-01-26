import 'package:flutter/material.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';

class TestRestaurantOverview extends StatefulWidget {
  static String id = 'restaurant_overview';

  @override
  _TestRestaurantOverviewState createState() => _TestRestaurantOverviewState();
}

class _TestRestaurantOverviewState extends State<TestRestaurantOverview> {
  bool isMenuSelected = true;
  bool isReviewSelected = false;

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.pin_drop,
                    size: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Text("Direction",
                              style: TextStyle(
                                color: Color.fromRGBO(240, 54, 54, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )),
                        ],
                      ),
                      Text(
                        "Sector 12, House No. 14, Rohni, Delhi",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromRGBO(107, 107, 107, 1)),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text("Location of other outlets",
                              style: TextStyle(
                                color: Color.fromRGBO(240, 54, 54, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              )),
                          Icon(Icons.arrow_drop_down_sharp),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.lock_clock,
                    size: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Timings",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "12pm - 10pm (Today)",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color.fromRGBO(107, 107, 107, 1)),
                          ),
                          Icon(Icons.arrow_drop_down_sharp),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.monetization_on_rounded,
                    size: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cost",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Cost for two - ₹500 (approx.)",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromRGBO(107, 107, 107, 1)),
                      ),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.star_border,
                    size: 32,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "(125 Reviews)",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color.fromRGBO(107, 107, 107, 1)),
                      ),
                    ],
                  )
                ]),
              ),
              // Container(child: RestuarantDeliveryReview()),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.35,
                child: RestuarantDeliveryReview(),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Menu",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                          ),
                          Text(
                            "5 pages",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Color.fromRGBO(107, 107, 107, 1)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.21,
                        child: ListView(
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Image.asset('assets/images/menu.png'),
                              Image.asset('assets/images/menu.png'),
                              Image.asset('assets/images/menu.png'),
                              Image.asset('assets/images/menu.png'),
                              Image.asset('assets/images/menu.png'),
                              Image.asset('assets/images/menu.png'),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.05),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: null,
                                  child: Center(
                                    child: Text(
                                      "See Full Menu",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.yellow),
                                    ),
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Spacer(),
          overviewBottomWidget(),
        ],
      ),
    );
  }
}

class overviewBottomWidget extends StatelessWidget {
  const overviewBottomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
          ),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Other Info",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,
                  top: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Home Delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Text(
                      "Takeaway Available",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Text(
                      "Vegetarian Only",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.008,
                    ),
                    Text(
                      "Indoor Seating allowed",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color.fromRGBO(107, 107, 107, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        overViewBottomWidgetSecond(),
      ],
    );
  }
}

class overViewBottomWidgetSecond extends StatelessWidget {
  const overViewBottomWidgetSecond({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Other Info",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06,
              top: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Wrap(
              children: [
                Text(
                  "All Rights Reseved",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color.fromRGBO(107, 107, 107, 1),
                  ),
                ),
                VerticalDivider(
                  color: Color.fromRGBO(107, 107, 107, 1),
                  thickness: 1,
                  width: 1,
                ),
                Text(
                  "Contact",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color.fromRGBO(107, 107, 107, 1),
                  ),
                ),
                VerticalDivider(
                  color: Color.fromRGBO(107, 107, 107, 1),
                  thickness: 1,
                  width: 1,
                ),
                Text(
                  "Terms of Service",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color.fromRGBO(107, 107, 107, 1),
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                  width: 1,
                ),
                Text(
                  "Privacy and Policies",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color.fromRGBO(107, 107, 107, 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
