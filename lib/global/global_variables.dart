import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

GeoPoint? currentLocation;
final ValueNotifier<int> totalPrice = ValueNotifier<int>(0);
final ValueNotifier<double> totalPriceMain = ValueNotifier<double>(0.0);

final ValueNotifier<int> couponPercentage = ValueNotifier<int>(0);

final ValueNotifier<int> totalItemsInCart = ValueNotifier<int>(0);
