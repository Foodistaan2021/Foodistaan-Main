import 'package:geocoding/geocoding.dart';

class GetAddressDetails {
  getAddress(latitude, longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark places = placemarks[0];
    print('Address Detials ${places.name}');
  }
}
