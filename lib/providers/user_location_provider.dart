import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:geocoding/geocoding.dart';

class UserLocationProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  GeoPoint? _userLocation;
  bool _hasUserLocation = false;
  bool _userLocationIsNull = true;
  AddressModel? _userAddress;

  GeoPoint? get userLocation => _userLocation;
  bool get hasUserLocation => _hasUserLocation;
  AddressModel? get userAddress => _userAddress;
  bool get userLocationIsNull => _userLocationIsNull;

  getUserLocation() async {
    await _firestore.collection('users').doc(userNumber).get().then((v) {
      v.data()!.forEach((key, value) {
        //if 'user-location' exists in the database
        //stores it in the database
        if (key == 'user-location') _userLocation = value;
      });
    });

    if (_userLocation != null) {
      _userAddress =
          await getAddress(_userLocation!.latitude, _userLocation!.longitude);
      _hasUserLocation = true;
      _userLocationIsNull = false;
    } else {
      _userLocationIsNull = true;
    }

    notifyListeners();
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
}
