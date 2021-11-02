import 'package:cloud_firestore/cloud_firestore.dart';

class Data
{
  final CollectionReference RestaurantCollection = FirebaseFirestore.instance.collection('Restaurant');
}