import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderFunction {
  final _firestore = FirebaseFirestore.instance;
  placeOrder(
      vendorId, vendorName, userNumber, items, totalPrice, paymentId) async {
    String id = _firestore.collection('live-orders').doc().id;
    DateTime time = DateTime.now();
    await _firestore.collection('live-orders').doc(id).set({
      'vendor-id': vendorId,
      'vendor-name': vendorName,
      'order-id': id,
      'items': items,
      'total-bill': totalPrice,
      'order-status': 'preparing',
      'customer-id': userNumber,
      'time': time,
      'payment-id': paymentId,
    });
    return null;
  }
}
