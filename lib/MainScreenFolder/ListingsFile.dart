import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/global/global_variables.dart' as global;

List items = [];
List sortItems = [];
List vendor_id_list = [];

fetchData(String category) async {
  final CollectionReference StreetFoodList =
      FirebaseFirestore.instance.collection(category);
  try {
    items = [];
    sortItems = [];
    await StreetFoodList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            items.add(element.data());
            vendor_id_list.add(element.id);
          })
        });
    if (global.currentLocation == null) {
      for (int i = 0; i < items.length; i++) {
        sortItems.add(items[i]);
        sortItems[i]['Distance'] = (items[i]['Location'].latitude - 0).abs() +
            (items[i]['Location'].longitude - 0).abs();
      }
      sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
    } else {
      for (int i = 0; i < items.length; i++) {
        sortItems.add(items[i]);
        sortItems[i]['Distance'] = (items[i]['Location'].latitude -
                    global.currentLocation!.latitude)
                .abs() +
            (items[i]['Location'].longitude - global.currentLocation!.longitude)
                .abs();
      }
      sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
    }
  } catch (e) {
    print(e.toString());
  }
  return sortItems;
}

class Listings extends StatefulWidget {

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData('DummyData').then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return items.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 11,
                    ),
                child: ListedTile(
                    details: items[index],Id: vendor_id_list[index],),
              );
            },
          )
        : CircularProgressIndicator();
  }
}

class ListedTile extends StatefulWidget {
  var details;
  var Id;
  ListedTile({this.details, this.Id});
  @override
  _ListedTileState createState() =>
      _ListedTileState(StreetFoodDetails: details, Vendor_ID: Id);
}

class _ListedTileState extends State<ListedTile> {
  var StreetFoodDetails;
  var Vendor_ID;
  _ListedTileState({this.StreetFoodDetails, this.Vendor_ID});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDelivery(
                      items: StreetFoodDetails,
                      vendor_id: Vendor_ID,
                      vendorName: StreetFoodDetails['Name'],
                    )));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3,
              spreadRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            leftSide(
              foodImage: StreetFoodDetails['FoodImage'],
              address: StreetFoodDetails['Address'],
            ),
            rightSide(
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
    );
  }
}

class leftSide extends StatelessWidget {
  String foodImage;
  String address;
  leftSide({this.foodImage = 'NA', this.address = 'NA'});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(11),
          bottomLeft: Radius.circular(11),
        ),
        color: Color(0xffE43B3B),
      ),
      height: h1 / 5,
      width: 3 * w1 / 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
            ),
            child: Image.network(
              foodImage,
              height: 10 * h1 / 62,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: h1 / 26,
            width: w1 / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(11),
              ),
              color: Color(0xffE43B3B),
            ),
            child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: h1/55,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: h1/77,
                            color: Colors.white,
                            // fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class rightSide extends StatelessWidget {
  String name;
  String cuisines;
  int stars;
  int cost;
  bool delivery;
  bool takeaway;
  bool foodistaanCertified;

  rightSide(
      {this.name = 'NA',
      this.cuisines = 'NA',
      this.stars = 4,
      this.cost = 100,
      this.delivery = false,
      this.takeaway = false,
      this.foodistaanCertified = false});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 10 * h1 / 62,
          width: w1 / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(11),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                      ),
                    )),
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      cuisines,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: h1 / 65),
                    )),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(stars, (index) {
                        return Image.asset(
                          'Images/RatingStar.png',
                          height: h1 / 35,
                          width: w1 / 35,
                        );
                      })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "Images/RupeeImage.png",
                      height: h1 / 50,
                    ),
                    SizedBox(
                      width: w1 / 100,
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Cost for two: $cost",
                        style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontSize: h1 / 70),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
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
                            width: w1 / 100,
                          ),
                          Text(
                            "Delivery",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.w600,
                                fontSize: h1 / 70),
                          )
                        ],
                      )
                    : SizedBox(
                  height: 2,
                ),
                takeaway == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "Images/TakeawayImage.png",
                            height: h1 / 50,
                          ),
                          SizedBox(
                            width: w1 / 100,
                          ),
                          Text(
                            "Takeaway",
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.w600,
                                fontSize: h1 / 70),
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
          width: w1 / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(11),
            ),
            color:
                foodistaanCertified == true ? Color(0xffF7C12B) : Colors.white,
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
                      fontWeight: FontWeight.w800),
                ),
              )),
        )
      ],
    );
  }
}
