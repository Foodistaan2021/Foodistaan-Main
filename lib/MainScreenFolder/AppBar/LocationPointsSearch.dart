import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/MainScreenFolder/AppBar/points.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/providers/user_location_provider.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  AddressModel? userAddress;
  bool hasAddress = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserLocationProvider>().getUserLocation();

    var h1 = MediaQuery.of(context).size.height;
    return FittedBox(
      alignment: Alignment.bottomLeft,
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xFFFAB84C),
            size: h1 * 0.055,
          ),
          SizedBox(
            width: 11,
          ),
          Consumer<UserLocationProvider>(
              builder: (context, userLocationValue, userLocationWidget) {
            return userLocationValue.hasUserLocation == true &&
                    userLocationValue.userLocationIsNull == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userLocationValue.userAddress!.name!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: h1 * 0.033,
                        ),
                      ),
                      Text(
                        userLocationValue.userAddress!.subLocality!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: h1 * 0.03,
                        ),
                      )
                    ],
                  )
                : Text(
                    'Select Location',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  );
          }),
        ],
      ),
    );
  }
}

class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FsPoints()));
      },
      child: FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    color: Color(0xFFFAB84C),
                    fontSize: h1 * 0.033,
                  ),
                ),
                Text(
                  'Points',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: h1 * 0.033,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 11,
            ),
            SvgPicture.asset(
              'Images/fs_points.svg',
              height: h1 * 0.055,
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  searchQuery(String query, List items) async {
    for (var item in items) {
      RegExp regExp = new RegExp(query, caseSensitive: false);
      bool containe = regExp.hasMatch(item['search']);
      if (containe) {
        print(item['Name']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return Consumer<RestaurantListProvider>(builder: (_, value, __) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: SizedBox(
              height: h1 * 0.05,
              child: TextFormField(
                controller: _searchController,
                onChanged: (v) async {
                  await searchQuery(_searchController.text, value.items);
                },
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    hintText: 'Search Cuisines',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFFAB84C),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFFAB84C), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(11),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xFFFAB84C),
                        width: 1,
                      ),
                    )),
              ),
            ),
          ),
          _searchController.text.isNotEmpty ? SearchItemList() : Container(),
        ],
      );
    });
  }
}

class SearchItemList extends StatefulWidget {
  const SearchItemList({Key? key}) : super(key: key);

  @override
  _SearchItemListState createState() => _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {
  String isSelected = 'DELIVERY';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.08,
            ),
            height: MediaQuery.of(context).size.height * 0.08,
            // color: Colors.grey.shade300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  // blurRadius: 6.0,
                ),
              ],
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 'DELIVERY';
                      print(isSelected);
                    });
                  },
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.005,
                    width: MediaQuery.of(context).size.width * 0.45,
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(left: 3, right: 3),
                    // padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          // blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.black,
                    ),
                    child: Text(
                      'DELIVERY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = 'DINING';
                      print(isSelected);
                    });
                  },
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.005,
                    width: MediaQuery.of(context).size.width * 0.45,
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(left: 3, right: 3),
                    // padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          // blurRadius: 6.0,
                        ),
                      ],
                      color: Colors.transparent,
                    ),
                    child: Text(
                      'DINING',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: 400,
              margin: EdgeInsets.only(top: 10),
              color: Colors.white,
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return SearchListItemtile(
                      index: index,
                    );
                  })),
        ],
      ),
    );
  }
}

class SearchListItemtile extends StatelessWidget {
  final index;

  const SearchListItemtile({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        minVerticalPadding: 5,
        tileColor: Colors.white,
        leading: Container(
            width: 80, child: Image.asset('assets/images/icecream.png')),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RC IceCream',
              style: TextStyle(
                fontSize: 16,
                // color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Icecream',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                // fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                // blurRadius: 6.0,
              ),
            ],
          ),
          // color: Colors.grey.shade300,
          child: Text(
            'Promoted',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}




// Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(11),
//           ),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(0, 0, 0, 0.15),
//               spreadRadius: 3,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         height: h1 * 0.05,
//         width: double.infinity,
//         alignment: Alignment.centerLeft,
//         child: FittedBox(
//           fit: BoxFit.contain,
//           child: Center(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Icon(
//                   Icons.search,
//                   color: Color(0xFFFAB84C),
//                   size: h1 / 33,
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text(
//                   "Search Cuisines",
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: h1 * 0.023,
//                     //fontFamily: 'Segoe UI'
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )