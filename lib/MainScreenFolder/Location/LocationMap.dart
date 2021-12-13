import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:foodistan/MainScreenFolder/Location/get_address.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/functions/places_search_model.dart';

import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  Completer<GoogleMapController> _controller = Completer();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
  List<Marker> _markers = <Marker>[];
  Location _location = Location();
  List<PlaceSearch> testData = [];
  String _sessionToken = '';
  @override
  void initState() {
    super.initState();
  }

  asyncFunction(query) async {
    await LocationFunctions()
        .getAutocomplete(query, _sessionToken)
        .then((value) {
      setState(() {
        testData = value;
      });
    });
  }

  clearData() {
    setState(() {
      testData = [];
    });
  }

  bool _searchRequest = false, _isLoading = false;
  String searchFeildValue = "";

  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget customSearchBar = const Text('Search for places');
  final searchFeildController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'H');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff7c12b),
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  if (_sessionToken == '') {
                    setState(() {
                      _sessionToken = Uuid().v4();
                    });
                  }
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar = ListTile(
                        leading: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 16,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            if (searchFeildController.text.length > 3)
                              asyncFunction(searchFeildController.text);
                          },
                        ),
                        title: TextFormField(
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: asyncFunction,
                          controller: searchFeildController,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'please Enter';
                            else
                              return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (value) async {},
                        ),
                      );
                    } else {
                      setState(() {
                        testData = [];
                        _sessionToken = '';
                      });
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Search For Places');
                    }
                  });
                },
                icon: customIcon)
          ],
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
            ),
            testData.isNotEmpty
                ? Container(
                    child: ListView.builder(
                        itemCount: testData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await pointToSelectedLocation(
                                  testData[index].placeId);
                            },
                            child: ListTile(
                              title: Text(testData[index].description),
                            ),
                          );
                        }),
                    height: 300.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.6),
                        backgroundBlendMode: BlendMode.darken),
                  )
                : Center(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFFF7C12B),
          onPressed: () async {
            await getCurrentLocation();
          },
          label: const Text('Get Location'),
          icon: const Icon(Icons.location_pin),
        ),
      ),
    );
  }

  pointToSelectedLocation(placeId) async {
    GeoPoint locationPoint =
        await LocationFunctions().getPlaceFromPlaceId(placeId);

    await LocationFunctions()
        .updateUserLocation(locationPoint.latitude, locationPoint.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17.0,
        target: LatLng(locationPoint.latitude, locationPoint.longitude))));

    addMarker(locationPoint);
    setState(() {
      testData = [];
    });
  }

  addMarker(locationPoint) {
    _markers = [];
    _markers.add(Marker(
        markerId: MarkerId(''),
        position: LatLng(locationPoint.latitude, locationPoint.longitude)));
  }

  getCurrentLocation() async {
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
    await LocationFunctions()
        .updateUserLocation(locationData.latitude!, locationData.longitude!);

    addMarker(locationData);
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17.0,
      ),
    ));
    await GetAddressDetails()
        .getAddress(locationData.latitude!, locationData.longitude!);
    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
