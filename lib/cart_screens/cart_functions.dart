import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/auth/autentication.dart';

class CartFunctions {
  addItemToCart(user_number, menu_iten_id, vendor_id) async {
   
    final _firestore = FirebaseFirestore.instance;
    final snapShot = await _firestore
        .collection("users")
        .doc(user_number)
        .collection("cart")
        .doc(vendor_id)
        .collection('cart-items')
        .doc(menu_iten_id)
        .get();
    // .collection('cart-items')
    // .doc(menu_iten_id)
    // .get();

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
                  'quantity': '1'
                })
              });

      // await _firestore
      //     .collection('users')
      //     .doc(user_number)
      //     .collection("cart-list-1")
      //     .doc(vendor_id)
      //     .collection('cart-items')
      //     .doc(menu_iten_id)
      //     .set({});
      //     .collection('cart-items')
      //     .doc(menu_iten_id)
      //     .set({
      //   'menu_item_id': menu_iten_id,
      //   'vendor_id': vendor_id,
      //   'id': cart_item_id,
      //   'quantity': '1'
      // });

      return 'Item Added to Cart';
    }
  }

  // fetchCart() async {

  //   if (snapShot.isEmpty == true) {
  //     print('Cart Empty');
  //   } else {
  //     final CollectionReference CartItems =
  //         _firestore.collection('users').doc(userNumber).collection('cart');

  //     try {
  //       await CartItems.get().then((querySnapshot) => {
  //             querySnapshot.docs.forEach((element) {
  //               cartItems.add(element.data());
  //             })
  //           });
  //       print(cartItems);
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   }
  //   return cartItems;
  // }
}
