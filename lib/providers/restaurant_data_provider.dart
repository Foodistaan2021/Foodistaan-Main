import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantDataProvider extends ChangeNotifier {
  Map<String, dynamic> _restaurantData = {};
  final _firestore = FirebaseFirestore.instance;
  String _vendorId = '';
  String _couponId = '';
  bool _hasCoupon = false;

  bool _hasData = false;
  int _couponPercentage = 0;
  String _couponCode = '';
  int _minCouponValue = 0;
  bool _hasCouponData = false;
  int _maxCouponDiscount = 0;

  Map<String, dynamic> get restaurantData => _restaurantData;

  String get couponId => _couponId;

  bool get hasData => _hasData;
  bool get hasCoupon => _hasCoupon;

  int get couponPercentage => _couponPercentage;
  String get couponCode => _couponCode;
  int get minCouponValue => _minCouponValue;
  bool get hasCouponData => _hasCouponData;
  int get maxCouponDiscount => _maxCouponDiscount;

  getRestaurantData(cartId) async {
    await _firestore.collection('cart').doc(cartId).get().then((value) {
      _vendorId = value.data()!['vendor-id'];
      if (value.data()!.containsKey('coupon-id')) {
        _couponId = value.data()!['coupon-id'];
      }
    });

    await _firestore.collection('DummyData').doc(_vendorId).get().then((value) {
      _restaurantData = value.data()!;
    });

    if (_couponId.isNotEmpty) {
      await getCouponData(_couponId);
    }
    _hasData = true;
    notifyListeners();
  }

  getCouponData(couponId) async {
    await _firestore.collection('coupons').doc(couponId).get().then((value) {
      _couponPercentage = value.data()!['percentage'];
      _couponCode = value.data()!['code'];
      _minCouponValue = value.data()!['min-price'];
      _maxCouponDiscount = value.data()!['max-discount'];
    });
    _couponId = couponId;
    _hasCouponData = true;
    _hasCoupon = true;
  }

  removeCoupon(cartId) async {
    await _firestore.collection('cart').doc(cartId).update({'coupon-id': ''});
    _couponCode = '';
    _hasCoupon = false;
    _hasCouponData = false;
    _minCouponValue = 0;
    _couponPercentage = 0;
    _maxCouponDiscount = 0;
    notifyListeners();
  }

  addCoupon(cartId, couponId) async {
    await _firestore
        .collection('cart')
        .doc(cartId)
        .update({'coupon-id': couponId});
    await getCouponData(couponId);
    notifyListeners();
  }
}
