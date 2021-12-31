import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';

class AddressModel {
  final String? street;
  final String? country;
  final String? locality;
  final String? name;
  final String? subLocality;

  AddressModel(
      {this.street,
      required this.country,
      required this.locality,
      required this.name,
      required this.subLocality});
}
