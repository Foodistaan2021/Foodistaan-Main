import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFunctions {
  storeCartId(cartId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cartId', cartId);
  }

  getCartId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartId = prefs.getString('cartId');
    return cartId;
  }

  removeCartId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartId');
  }
}
