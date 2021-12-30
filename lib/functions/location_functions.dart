import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'places_search_model.dart';
import 'address_model.dart';

class LocationFunctions {
  final _firestore = FirebaseFirestore.instance;

  updateUserLocation(lattitude, longitude) async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    if (userNumber != '') {
      _firestore
          .collection('users')
          .doc(userNumber)
          .update({'user-location': GeoPoint(lattitude, longitude)});
    }
  }

  

  getUserLocation() async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    GeoPoint? userLocation;
    await _firestore.collection('users').doc(userNumber).get().then((v) {
      v.data()!.forEach((key, value) {
        if (key == 'user-location') userLocation = value;
      });
    });
    if (userLocation != null) {
      print('Fetcehed');
      return userLocation;
    }
    return null;
  }

  getAddress(latitude, longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark places = placemarks[0];

    AddressModel addressModel = createeAddressModel(places);
    return addressModel;
  }

  createeAddressModel(Placemark? places) {
    AddressModel addressModel = AddressModel(
        street: places!.street,
        country: places.country,
        locality: places.locality,
        name: places.name,
        subLocality: places.subLocality);
    return addressModel;
  }

  final API_KEY = 'AIzaSyA2D_qJoq8XQ6DRIo9wSfzelarrEm-ARZM';
  
  Future<List<PlaceSearch>> getAutocomplete(searchQuery, sessionToken) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&language=en&types=geocode&key=$API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;

    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<GeoPoint> getPlaceFromPlaceId(placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$API_KEY';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['result'];
    var locationDetails = jsonResults['geometry'];
    var latLongMap = locationDetails['location'];
    var latitude = latLongMap['lat'];
    var longitude = latLongMap['lng'];
    var formattedAddress = jsonResults['formatted_address'];
    return GeoPoint(latitude, longitude);
  }
}
