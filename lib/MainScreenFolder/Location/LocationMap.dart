import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/functions/address_model.dart';

import 'package:foodistan/functions/location_functions.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/functions/places_search_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddLocation extends StatefulWidget {
  var placeId;
  var placeSearched;
  AddLocation({required this.placeId, required this.placeSearched});

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
        print(value);
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'H');
        return true;
      },
      child: Scaffold(
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.28,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'Select Location',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                backgroundColor: Colors.white,
              ),
              hasAddress != false
                  ? ListTile(
                      leading: Icon(
                        FontAwesomeIcons.streetView,
                        color: Colors.yellowAccent,
                        size: 25,
                      ),
                      title: Text(
                        addressModel.name,
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text(
                          '${addressModel.street} ${addressModel.locality}'),
                      trailing: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              Text('Change', style: TextStyle(fontSize: 20))),
                    )
                  : Text('Set Location'),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF7C12B),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF7C12B),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await LocationFunctions()
                          .updateUserLocation(
                              userLocation.latitude, userLocation.longitude)
                          .then((value) {
                        Navigator.pushReplacementNamed(context, 'H');
                      });
                    },
                    child: Text(
                      'Confirm Location',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              )
            ],
          ),
        ),
        body: GoogleMap(
          myLocationButtonEnabled: false,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationEnabled: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF7C12B),
          onPressed: () async {
            await getCurrentLocation(_controller);
          },
          label: const Text('Get Location'),
          icon: const Icon(FontAwesomeIcons.mapMarkerAlt),
        ),
      ),
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
