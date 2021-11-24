import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/MainScreenFolder/ListingsFile.dart';
import 'package:foodistan/auth/autentication.dart';

class CartFunctions {
  List price = [{}];
  addItemToCart(user_number, menu_iten_id, vendor_id,price) async {
    final _firestore = FirebaseFirestore.instance;
    final snapShot = await _firestore
        .collection("users")
        .doc(user_number)
        .collection("cart")
        .doc(vendor_id)
        .collection('cart-items')
        .doc(menu_iten_id)
        .get();

    if (snapShot.exists) {
      return 'Cart Item Already Exists';
    } else {
      await _firestore
          .collection('users')
          .doc(user_number)
          .collection("cart")
          .doc(vendor_id)
          .set({}).whenComplete(() => {
                _firestore
                    .collection('users')
                    .doc(user_number)
                    .collection('cart')
                    .doc(vendor_id)
                    .collection('cart-items')
                    .doc(menu_iten_id)
                    .set({
                  'menu_item_id': menu_iten_id,
                  'vendor_id': vendor_id,
                  'quantity': '1',
                  'price': price
                })
              });

      await getSomething(user_number, menu_iten_id, 1, price, vendor_id);

      return 'Item Added to Cart';
    }
  }

  Future<DocumentSnapshot> fetchRestaurantsInCart(id) async {
    late DocumentSnapshot documentSnapshot;

    await FirebaseFirestore.instance
        .collection('DummyData')
        .doc(id)
        .get()
        .then((value) {
      documentSnapshot = value;
    });

    return documentSnapshot;
  }

  fetchMenuItem(vendor_id, item_id) async {
    List menu_item = [];

    var menuItem = await FirebaseFirestore.instance
        .collection('DummyData')
        .doc(vendor_id)
        .collection('menu-items')
        .where('id', isEqualTo: item_id);

    try {
      await menuItem.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              menu_item.add(element.data());
            })
          });
    } catch (e) {
      print(e.toString());
    }

    return menu_item.isEmpty ? [] : menu_item[0];
  }

  changeQuantity(vendor_id, item_id, inc_dec, quantity, user_number) async {
    final _firestore = FirebaseFirestore.instance;
    int _quantity = int.parse(quantity.toString());
    if (inc_dec) {
      if (_quantity < 5)
        await _firestore
            .collection('users')
            .doc(user_number)
            .collection('cart')
            .doc(vendor_id)
            .collection('cart-items')
            .doc(item_id)
            .update({'quantity': _quantity + 1});
    } else {
      if (_quantity > 1) {
        await _firestore
            .collection('users')
            .doc(user_number)
            .collection('cart')
            .doc(vendor_id)
            .collection('cart-items')
            .doc(item_id)
            .update({'quantity': _quantity - 1});
      }
    }
  }

  getPrice(base_price, quantity) {
    int _quantity = int.parse(quantity.toString());
    int price = int.parse(base_price.toString());

    int totalPrice = _quantity * price;

    var cartTotal = [{}];

    // List<dynamic> list = List.from(documentSnapshpt.data['cart-value']);
    // // FirebaseFirestore.instance.collection('users').doc('+917860116084').update({
    // //   'cart-total': FieldValue.arrayUnion(['item'])
    // // });

    return totalPrice;
  }

  Future<bool> isCartEmpty(userNumber) async {
    final _firestore = FirebaseFirestore.instance;
    final snapShot = await _firestore
        .collection("users")
        .doc(userNumber)
        .collection("cart")
        .doc()
        .get();

    if (snapShot.exists)
      return true;
    else
      return false;
  }

  getSomething(userNumber, itemId, quantity, price, vendorID) async {
    String uId = itemId + vendorID;
    var cartTotal = {};
    var documentSnapshpt = await FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .get()
        .then((value) {
      cartTotal = value['cart-total-map'];
    }).then((value) {
      if (cartTotal.containsKey(uId)) {
        cartTotal[uId] = getPrice(price, quantity);
      } else
        cartTotal[uId] = getPrice(price, quantity);
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .update({'cart-total-map': cartTotal});
  }
}
