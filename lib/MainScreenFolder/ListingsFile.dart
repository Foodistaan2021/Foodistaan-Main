import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/providers/user_address_provider.dart';
import 'package:foodistan/providers/user_location_provider.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/global/global_variables.dart' as global;
import 'package:provider/provider.dart';

// List items = [];
// List sortItems = [];
// List vendor_id_list = [];

// fetchData(String category) async {
//   final CollectionReference StreetFoodList =
//       FirebaseFirestore.instance.collection(category);
//   try {
//     items = [];
//     sortItems = [];
//     await StreetFoodList.get().then((querySnapshot) => {
//           querySnapshot.docs.forEach((element) {
//             items.add(element.data());
//             vendor_id_list.add(element.id);
//           })
//         });
//     if (global.currentLocation == null) {
//       for (int i = 0; i < items.length; i++) {
//         sortItems.add(items[i]);
//         sortItems[i]['Distance'] = (items[i]['Location'].latitude - 0).abs() +
//             (items[i]['Location'].longitude - 0).abs();
//       }
//       sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
//     } else {
//       for (int i = 0; i < items.length; i++) {
//         sortItems.add(items[i]);
//         sortItems[i]['Distance'] = (items[i]['Location'].latitude -
//                     global.currentLocation!.latitude)
//                 .abs() +
//             (items[i]['Location'].longitude - global.currentLocation!.longitude)
//                 .abs();
//       }
//       sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   return sortItems;
// }

class Listings extends StatefulWidget {
  var userLocation;

  Listings({this.userLocation});

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    context
        .read<RestaurantListProvider>()
        .fetchData('DummyData', widget.userLocation);
    return Consumer<RestaurantListProvider>(builder:
        (restaurantDatacontext, restaurantListValue, restaurantListWidget) {
      return restaurantListValue.hasData
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurantListValue.items.length,
              itemBuilder: (restaurantDatacontext, index) {
                return Padding(
                  padding: EdgeInsets.all(11),
                  child: ListedTile(
                    details: restaurantListValue.items[index],
                    Id: restaurantListValue.items[index]['id'],
                  ),
                );
              },
            )
          : CircularProgressIndicator(
              color: Colors.yellow,
            );
    });
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
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 7,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LeftSide(
                foodImage: StreetFoodDetails['FoodImage'],
              ),
              SizedBox(
                width: 5,
              ),
              RightSide(
                name: StreetFoodDetails['Name'],
                address: StreetFoodDetails['Address'],
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
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  String foodImage;
  // String address;
  LeftSide({this.foodImage = 'NA'});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Container(
        width: w1 * 0.4,
        height: h1 * 0.88,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(11),
          image: DecorationImage(
            image: NetworkImage(
              foodImage,
            ),
            fit: BoxFit.fitHeight,
            alignment: FractionalOffset.center,
          ),
        ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(11),
        //     bottomLeft: Radius.circular(11),
        //   ),
        //   color: Color(0xffE43B3B),
        // ),
        // height: h1 / 5,
        // width: 3 * w1 / 5,
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(11),
        //       ),
        //       child: Image.network(
        //         foodImage,
        //         height: 10 * h1 / 62,
        //         fit: BoxFit.fitWidth,
        //       ),
        //     ),
        //     Container(
        //       height: h1 / 26,
        //       width: w1 / 3,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(11),
        //         ),
        //         color: Color(0xffE43B3B),
        //       ),
        //       child: FittedBox(
        //           fit: BoxFit.contain,
        //           child: Padding(
        //             padding: const EdgeInsets.all(5),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 Icon(
        //                   Icons.location_on,
        //                   size: h1 / 55,
        //                   color: Colors.white,
        //                 ),
        //                 SizedBox(
        //                   width: 11,
        //                 ),
        //                 Text(
        //                   address,
        //                   style: TextStyle(
        //                     fontSize: h1 / 77,
        //                     color: Colors.white,
        //                     // fontWeight: FontWeight.w700,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )),
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  String name;
  String address;
  String cuisines;
  var stars;
  var cost;
  bool delivery;
  bool takeaway;
  var foodistaanCertified;

  RightSide(
      {this.name = 'NA',
      this.address = 'NA',
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        foodistaanCertified == true
            ? SizedBox()
            : SizedBox(
                height: 3,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.place_outlined,
              color: Colors.black,
              size: 12,
            ),
            SizedBox(
              width: 5,
            ),
            SafeArea(
              child: Text(
                address,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        foodistaanCertified == true
            ? SizedBox()
            : SizedBox(
                height: 3,
              ),
        Text(
          cuisines,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              Icon(
                Icons.star,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              Icon(
                Icons.star,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
              Icon(
                Icons.star,
                size: 15,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.pink,
              radius: 8,
              child: Center(
                child: Text(
                  '₹',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Cost for Two ₹ $cost',
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 8,
                    child: Center(
                      child: Icon(
                        Icons.two_wheeler,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Delivery',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 2,
        ),
        takeaway == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.pink,
                    radius: 8,
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Takeaway',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 2,
        ),
        foodistaanCertified == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'Images/fs_certified.png',
                    width: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Foodistaan Certified',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : SizedBox(),
        // Container(
        //   height: 10 * h1 / 62,
        //   width: w1 / 3,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(11),
        //     ),
        //     color: Colors.white,
        //   ),
        //   child: Padding(
        //     padding: EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         FittedBox(
        //             fit: BoxFit.contain,
        //             child: Text(
        //               name,
        //               style: TextStyle(
        //                 color: Colors.black,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             )),
        //         FittedBox(
        //             fit: BoxFit.contain,
        //             child: Text(
        //               cuisines,
        //               style: TextStyle(
        //                   color: Colors.grey,
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: h1 / 65),
        //             )),
        //         FittedBox(
        //           fit: BoxFit.contain,
        //           child: Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               children: List.generate(stars, (index) {
        //                 return Image.asset(
        //                   'Images/RatingStar.png',
        //                   height: h1 / 35,
        //                   width: w1 / 35,
        //                 );
        //               })),
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             Image.asset(
        //               "Images/RupeeImage.png",
        //               height: h1 / 50,
        //             ),
        //             SizedBox(
        //               width: w1 / 100,
        //             ),
        //             FittedBox(
        //               fit: BoxFit.fitWidth,
        //               child: Text(
        //                 "Cost for two: $cost",
        //                 style: TextStyle(
        //                     color: Colors.black,
        //                     // fontWeight: FontWeight.w600,
        //                     fontSize: h1 / 70),
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 2,
        //         ),
        //         delivery == true
        //             ? Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Image.asset(
        //                     "Images/DeliveryImage.png",
        //                     height: h1 / 50,
        //                   ),
        //                   SizedBox(
        //                     width: w1 / 100,
        //                   ),
        //                   Text(
        //                     "Delivery",
        //                     style: TextStyle(
        //                         color: Colors.black,
        //                         // fontWeight: FontWeight.w600,
        //                         fontSize: h1 / 70),
        //                   )
        //                 ],
        //               )
        //             : SizedBox(
        //                 height: 2,
        //               ),
        //         takeaway == true
        //             ? Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Image.asset(
        //                     "Images/TakeawayImage.png",
        //                     height: h1 / 50,
        //                   ),
        //                   SizedBox(
        //                     width: w1 / 100,
        //                   ),
        //                   Text(
        //                     "Takeaway",
        //                     style: TextStyle(
        //                         color: Colors.black,
        //                         // fontWeight: FontWeight.w600,
        //                         fontSize: h1 / 70),
        //                   )
        //                 ],
        //               )
        //             : SizedBox(),
        //       ],
        //     ),
        //   ),
        // ),
        // Container(
        //   height: h1 / 26,
        //   width: w1 / 3,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(11),
        //     ),
        //     color:
        //         foodistaanCertified == true ? Color(0xffF7C12B) : Colors.white,
        //   ),
        //   child: FittedBox(
        //       fit: BoxFit.contain,
        //       child: Padding(
        //         padding:
        //             EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
        //         child: Text(
        //           "Foodistaan Certified",
        //           style: TextStyle(
        //               color: Colors.white, fontWeight: FontWeight.w800),
        //         ),
        //       )),
        // )
      ],
    );
  }
}
