import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';

Future<dynamic> getRequest(String url) async {
  String url = "";
  http.Response response = await http.get(Uri.parse(url));
  print(response.statusCode);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return jsonResponse;
  }
}

Future<Position> getCurrentPosition() async {
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  @override
  var placemarks;
  Set<Marker> locationMarkers = {};
  setCurrentLocation() async {
    currentLocation = await getCurrentPosition();
    placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    locationMarkers.add(
      Marker(
        markerId: MarkerId('ID1'),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
      ),
    );
    setState(() {});
  }

  void initState() {
    setCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentLocation == null
            ? Text('Fetching Location...')
            : Text(
                '${currentLocation.latitude}, ${currentLocation.longitude}',
              ),
        //title: TextField(decoration: InputDecoration(hintText: 'Enter Location'),),
        centerTitle: true,
        leading: IconButton(
          icon: new Icon(Icons.ac_unit),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              )),
        ),
      ),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 15,
              ),
              markers: locationMarkers,
            ),
    );
  }
}
