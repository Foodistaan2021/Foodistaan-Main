import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantListProvider extends ChangeNotifier {
  List _items = [];
  List _sort_items = [];
  List _vendor_id_list = [];
  bool _hasData = false;

  List get items => _items;
  List get sort_items => _sort_items;
  List get vendor_id_list => _vendor_id_list;
  bool get hasData => _hasData;

  fetchData(String category, location) async {
    final CollectionReference StreetFoodList =
        FirebaseFirestore.instance.collection(category);
    try {
      _items = [];
      _sort_items = [];
      await StreetFoodList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              _items.add(element.data());
              _vendor_id_list.add(element.id);
            })
          });
      if (location == null) {
        for (int i = 0; i < _items.length; i++) {
          _sort_items.add(_items[i]);
          _sort_items[i]['Distance'] =
              (_items[i]['Location'].latitude - 0).abs() +
                  (_items[i]['Location'].longitude - 0).abs();
        }
        _sort_items.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
      } else {
        for (int i = 0; i < _items.length; i++) {
          _sort_items.add(_items[i]);
          _sort_items[i]['Distance'] =
              (_items[i]['Location'].latitude - location!.latitude).abs() +
                  (_items[i]['Location'].longitude - location!.longitude).abs();
        }
        _sort_items.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
      }
    } catch (e) {
      print(e.toString());
    }

    _items = _sort_items;
    _hasData = true;
    notifyListeners();
  }
}
