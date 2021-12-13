import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/MainScreenFolder/Location/LocationMap.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/global/global_variables.dart' as global;

class LocationBottomSheetWidget extends StatefulWidget {
  const LocationBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheetWidget> createState() =>
      _LocationBottomSheetWidgetState();
}

class _LocationBottomSheetWidgetState extends State<LocationBottomSheetWidget> {
  String userAddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (global.currentLocation != null) {
      LocationFunctions()
          .getAddress(global.currentLocation!.latitude,
              global.currentLocation!.longitude)
          .then((value) {
        setState(() {
          userAddress = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Select Location',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddLocation())),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: Icon(FontAwesomeIcons.mapPin)),
                    Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Use Your Current Location'),
                            Text(userAddress),
                          ],
                        )),
                    Expanded(flex: 1, child: Icon(FontAwesomeIcons.arrowRight))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
