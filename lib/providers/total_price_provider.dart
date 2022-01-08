import 'package:flutter/material.dart';
import 'package:foodistan/functions/cart_functions.dart';

class TotalPriceProvider extends ChangeNotifier {
  int _totalPriceProvider = 0;

  int get totalPriceProvider => _totalPriceProvider;

  getTotalPrice(itemData) {
    // itemData = data of each cart item
    _totalPriceProvider = int.parse(CartFunctions().totalPrice(itemData));
    notifyListeners();
  }
}
