
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAddressProvider extends ChangeNotifier {
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  final _firestore = FirebaseFirestore.instance;
  String _addressId = '';
  bool _hasDefaultAddress = false;
  Map<String, dynamic> _addressData = {};

  bool get hasDeafultAddress => _hasDefaultAddress;
  String get addressId => _addressId;
  Map<String, dynamic> get addressData => _addressData;

  checkDefaultDeliveryAddress() async {
    await _firestore.collection('users').doc(userNumber).get().then((value) {
      if (value.data()!.containsKey('address-id')) {
        _addressId = value.data()!['address-id'];
        _hasDefaultAddress = true;
      } else {
        _hasDefaultAddress = false;
      }
    });
    if (_hasDefaultAddress == true) {
      await getAddressData(_addressId, userNumber);
    }
    notifyListeners();
  }

  getAddressData(addressId, userNumber) async {
    await _firestore
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .doc(addressId)
        .get()
        .then((value) {
      _addressData = value.data()!;
    });
  }

  addUserAddress(
      houseFeild, streetFeild, category, location, addressData) async {
    _addressId = _firestore
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .doc()
        .id;
    await _firestore
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .doc(_addressId)
        .set({
      'house-feild': houseFeild,
      'street-feild': streetFeild,
      'category': category,
      'user-location': GeoPoint(location.latitude, location.longitude),
    }).then((value) {
      addressData = {
        'house-feild': houseFeild,
        'street-feild': streetFeild,
        'category': category,
        'user-location': GeoPoint(location.latitude, location.longitude)
      };
    }).then((value) {
      _firestore
          .collection('users')
          .doc(userNumber)
          .update({'address-id': _addressId});
    });
    _addressData = addressData;
    _hasDefaultAddress = true;
    notifyListeners();
  }

  selectAddress(addressId, addressData) async {
    await _firestore
        .collection('users')
        .doc(userNumber)
        .update({'address-id': addressId});
    await _firestore
        .collection('users')
        .doc(userNumber)
        .update({'user-location': addressData['user-location']});
        
    _hasDefaultAddress = true;

    _addressData = addressData;
    _addressId = addressId;
    notifyListeners();
  }
}
