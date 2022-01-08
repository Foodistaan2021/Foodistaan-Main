import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/MainScreenFolder/address_screen.dart';

import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/functions/places_search_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../HomeScreenFile.dart';

class AddLocation extends StatefulWidget {
  bool isAddingAddress;
  var placeId;
  var placeSearched;
  AddLocation(
      {required this.placeId,
      required this.placeSearched,
      required this.isAddingAddress});

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
  List<Marker> _markers = <Marker>[];

  Completer<GoogleMapController> _controller = Completer();

  var addressModel = null;
  bool hasAddress = false;

  GeoPoint userLocation = GeoPoint(21.00, 21.00);

  @override
  void initState() {
    super.initState();
    var controller = _controller;
    if (widget.placeSearched == true) {
      pointToSelectedLocation(widget.placeId).then((value) {
        setState(() {
          userLocation = value;
        });
      });
    } else {
      asyncFunctionInitial(controller).then((value) {
        setState(() {
          addressModel = value;
          hasAddress = true;
        });
      });
    }
  }

  asyncFunctionInitial(controller) async {
    LatLng currentLocation = await getCurrentLocation(controller);
    AddressModel addressModel = await LocationFunctions()
        .getAddress(currentLocation.latitude, currentLocation.longitude);
    setState(() {
      userLocation =
          GeoPoint(currentLocation.latitude, currentLocation.longitude);
    });

    return addressModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Location',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(11),
                        topEnd: Radius.circular(11),
                      ),
                    ),
                    padding: EdgeInsets.all(11),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Select Location',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.055,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: MediaQuery.of(context).size.width *
                                          0.055,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          hasAddress != false
                              ? ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.037,
                                  ),
                                  title: Text(
                                    '${addressModel.name}, ${addressModel.street}, ${addressModel.locality}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                    ),
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Change',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.031,
                                      ),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Please Select Your Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                  ),
                                ),
                          Divider(
                            color: Colors.grey,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await LocationFunctions()
                                  .updateUserLocation(userLocation.latitude,
                                      userLocation.longitude)
                                  .then((value) {
                                widget.isAddingAddress == false
                                    ? Navigator.pushNamedAndRemoveUntil(
                                        context, 'H', (route) => false)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressScreen()));
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Confirm Location',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: !widget.placeSearched
      //     ? FloatingActionButton.extended(
      //         backgroundColor: Color(0xFFF7C12B),
      //         onPressed: () async {
      //           await getCurrentLocation(_controller);
      //         },
      //         label: const Text('Get Location'),
      //         icon: const Icon(FontAwesomeIcons.mapMarkerAlt),
      //       )
      //     : null,
    );
  }

  pointToSelectedLocation(placeId) async {
    GeoPoint locationPoint =
        await LocationFunctions().getPlaceFromPlaceId(placeId);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17.0,
        target: LatLng(locationPoint.latitude, locationPoint.longitude))));

    await LocationFunctions()
        .getAddress(locationPoint.latitude, locationPoint.longitude)
        .then((value) {
      setState(() {
        addressModel = value;
        hasAddress = true;
      });
    });
    addMarker(locationPoint);
    return locationPoint;
  }

  addMarker(locationPoint) {
    _markers = [];
    _markers.add(Marker(
        markerId: MarkerId(''),
        position: LatLng(locationPoint.latitude, locationPoint.longitude)));
  }

  getCurrentLocation(_controller) async {
    final GoogleMapController controller = await _controller.future;
    Location location = new Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }
    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }
    final locationData = await location.getLocation();

    addMarker(locationData);

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17.0,
      ),
    ));
    await LocationFunctions()
        .getAddress(locationData.latitude!, locationData.longitude!)
        .then((value) {
      setState(() {
        addressModel = value;
      });
    });
    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
