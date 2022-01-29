import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

  Map<String, dynamic> _userData = {};
  Map<String, dynamic> get userData => _userData;
  getUserData() async {
    await _firestore.collection('users').doc(userNumber).get().then((value) {
      _userData = value.data()!;
    });
    notifyListeners();
  }

  List _bookMarks = [];
  bool _hasBookMarks = false;
  List _bookMarkRestaurantData = [];

  List get bookMarks => _bookMarks;

  bool get hasBookMarks => _hasBookMarks;

  List get bookMarkRestaurantData => _bookMarkRestaurantData;

  addBookmark(restaurantId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .update({
      'bookmarks': FieldValue.arrayUnion([restaurantId])
    });

    notifyListeners();
  }

  bool _isRestaurantBookMarked = false;
  bool get isRestaurantBookMarked => _isRestaurantBookMarked;

  checkBookmark(restaurantID) async {
    await getUserData();
    //breakpoint
    if (_userData.isEmpty) return false;

    if (_userData.containsKey('bookmarks')) {
      List bookMarkTemp = _userData['bookmarks'];
      print(bookMarkTemp.toString());

      if (bookMarkTemp.contains(restaurantID)) {
        return true;
      } else {
        return false;
      }
    }
    notifyListeners();
  }
}
