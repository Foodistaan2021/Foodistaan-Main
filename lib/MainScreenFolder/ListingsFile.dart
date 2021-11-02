import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:auto_size_text/auto_size_text.dart';

List items = [];
List vendor_id_list = [];
Future<List> fetchData() async {
  List items = [];
  final CollectionReference StreetFoodList =
      FirebaseFirestore.instance.collection('DummyData');
  try {
    await StreetFoodList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            items.add(element.data());
            vendor_id_list.add(element.id);
          })
        });
  } catch (e) {
    print(e.toString());
  }
  return items;
}

class leftSide extends StatelessWidget {
  String foodImage;
  String address;
  var h1;
  var w1;
  leftSide(
      {required this.foodImage,
      required this.address,
      required this.h1,
      required this.w1});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.0),
            bottomLeft: Radius.circular(7.0),
          ),
          color: Color(0xffE43B3B),
        ),
        height: h1 / 5,
        width: w1 * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.0),
              ),
              child: Image.network(
                foodImage,
                height: 10 * h1 / 62,
                fit: BoxFit.cover,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: h1 / 26,
                width: w1 / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7.0),
                  ),
                  color: Color(0xffE43B3B),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(w1 / 50, h1 / 100, w1 / 50, h1 / 150),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: h1 / 7,
                    ),
                    child: AutoSizeText(
                      address,
                      style: TextStyle(color: Colors.white, fontSize: 13
                          // fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
      Positioned(
          top: 10.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            height: 30,
            width: 60,
            child: Center(
              child: Row(children: [
                Icon(
                  Icons.circle_notifications_sharp,
                  color: Colors.white,
                  size: 18,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '50%',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ]),
            ),
          )),
    ]);
  }
}

class ListedTile extends StatefulWidget {
  var details;
  var vendor_id;
  ListedTile({this.details, this.vendor_id});
  @override
  _ListedTileState createState() =>
      _ListedTileState(StreetFoodDetails: details, Vendor_ID: vendor_id);
}

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class rightSide extends StatelessWidget {
  String name;
  String cuisines;
  int stars;
  int cost;
  bool delivery;
  bool takeaway;
  bool foodistaanCertified;
  var h1;
  var w1;

  rightSide(
      {required this.name,
      required this.cuisines,
      required this.stars,
      required this.cost,
      required this.delivery,
      required this.takeaway,
      required this.foodistaanCertified,
      required this.h1,
      required this.w1});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 10 * h1 / 62,
            width: w1 * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7.0),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    cuisines,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: h1 / 70,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(stars, (index) {
                        return Image.asset(
                          'Images/RatingStar.png',
                          height: h1 / 35,
                          width: w1 / 35,
                        );
                      })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "Images/RupeeImage.png",
                        height: h1 / 50,
                      ),
                      SizedBox(
                        width: w1 / 50,
                      ),
                      Text(
                        "Cost for two:" + cost.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: h1 / 65),
                      ),
                    ],
                  ),
                  delivery == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "Images/DeliveryImage.png",
                              height: h1 / 50,
                            ),
                            SizedBox(
                              width: w1 / 50,
                            ),
                            Text(
                              "Delivery",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: h1 / 65),
                            )
                          ],
                        )
                      : SizedBox(),
                  takeaway == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "Images/TakeawayImage.png",
                              height: h1 / 50,
                            ),
                            SizedBox(
                              width: w1 / 50,
                            ),
                            Text(
                              "Takeaway",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: h1 / 65),
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          Container(
            height: h1 / 26,
            width: w1 * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(7.0),
              ),
              color: foodistaanCertified == true
                  ? Color(0xffF7C12B)
                  : Colors.white,
            ),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
                  child: Text(
                    "Foodistaan Certified",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class _ListedTileState extends State<ListedTile> {
  var StreetFoodDetails;
  var Vendor_ID;
  _ListedTileState({this.StreetFoodDetails, this.Vendor_ID});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDelivery(
                      items: StreetFoodDetails,
                      vendor_id: Vendor_ID,
                    )));
      },
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 0.5,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              leftSide(
                foodImage: StreetFoodDetails['FoodImage'],
                address: StreetFoodDetails['Address'],
                h1: h1,
                w1: w1,
              ),
              rightSide(
                h1: h1,
                w1: w1,
                name: StreetFoodDetails['Name'],
                cuisines: StreetFoodDetails['Cuisines'],
                stars: StreetFoodDetails['Stars'],
                cost: StreetFoodDetails['Cost'],
                delivery: StreetFoodDetails['Delivery'],
                takeaway: StreetFoodDetails['Takeaway'],
                foodistaanCertified: StreetFoodDetails['FoodistaanCertified'],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return items.isEmpty
        ? CircularProgressIndicator()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(w1 / 30, h1 / 50, w1 / 30, h1 / 50),
                child: ListedTile(
                  details: items[index],
                  vendor_id: vendor_id_list[index],
                ),
              );
            },
          );
  }
}
