import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/MainScreenFolder/AppBar/points.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:foodistan/functions/location_functions.dart';
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

class Search extends StatelessWidget {
  final _searchController = TextEditingController();

  searchQuery(String query) async {
    final _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('DummyData')
        .where(
          'search',
          isGreaterThanOrEqualTo: query.toLowerCase(),
        )
        .get()
        .then((value) {
      QuerySnapshot<Map<String, dynamic>> v = value;
      for (var item in v.docs) {
        print(item.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: SizedBox(
        height: h1 * 0.05,
        child: TextFormField(
          controller: _searchController,
          onChanged: (v) async {
            await searchQuery(_searchController.text);
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
                  borderSide: BorderSide(color: Color(0xFFFAB84C), width: 1),
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