import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartIdProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  bool _error = false;
  String _cartId = '';
  bool _hasData = false;

  bool get error => _error;

  String get cartId => _cartId;

  bool get hasData => _hasData;

  getCartId() async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    await _firestore
        .collection('users')
        .doc(userNumber)
        .get()
        .then((value) => {_cartId = value.data()!['cart-id']});
    _hasData = true;
    notifyListeners();
  }
}
