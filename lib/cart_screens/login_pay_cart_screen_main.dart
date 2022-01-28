import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/coupon_screen.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/functions/razorpay_integration.dart';
import 'package:foodistan/profile/profile_address.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/providers/cart_id_provider.dart';
import 'package:foodistan/providers/restaurant_data_provider.dart';
import 'package:foodistan/providers/total_price_provider.dart';
import 'package:foodistan/providers/user_address_provider.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import 'package:provider/provider.dart';

int maxCouponDiscount = 0;
String couponCode = '';
int minCouponValue = 0;
Map<String, dynamic> itemMap = {};

class CartScreenMainLogin extends StatefulWidget {
  String routeName = 'cart';

  @override
  State<CartScreenMainLogin> createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget checkIfAnyOrders(userNumber) {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .snapshots();
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var count = snapshot.data!.docs.length;
            if (count > 0)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 33,
                  ),
                  Text(
                    'You Have Existing Orders',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF7C12B),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Orders()));
                    },
                    child: Text('Track Order'),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'H');
                      },
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.yellow.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Place Another Order',
                            style: TextStyle(
                              color: Colors.yellow.shade700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            else
              return Padding(
                padding: const EdgeInsets.all(11),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'H');
                  },
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.yellow.shade700,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        'Add Items to Cart',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'H');
                },
                child: Container(
                  height: 35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.yellow.shade700,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      'Add Items to Cart',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget cartItems(cartId) {
    var stream = FirebaseFirestore.instance
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            //if already items exists in the cart it will display cart items
            //if there are no items in the cart
            //it will see if there exits any order
            //then render the widget accordingly
            if (snapshot.data!.docs.length != 0) {
              return CartItemsWidget(data: snapshot.data!.docs, cartId: cartId);
            }
          }
          String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
          return checkIfAnyOrders(userNumber);
        });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CartIdProvider>(context, listen: false).getCartId();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Consumer<CartIdProvider>(builder: (context, value, child) {
                return value.hasData == false
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(11),
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : cartItems(value.cartId);
              })
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemsWidget extends StatefulWidget {
  //receving menu items data before hand
  //becoz of the stream
  List<DocumentSnapshot> data;
  String cartId;
  CartItemsWidget({required this.data, required this.cartId});

  @override
  _CartItemsWidgetState createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  Widget menuItemWidget(itemData) {
    itemMap[itemData['id']] = itemData['quantity'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Center(
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 11,
                    ),
                    itemData['veg'] == true
                        ? Image.asset('assets/images/green_sign.png')
                        : Image.asset('assets/images/red_sign.png'),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      itemData['name'],
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await CartFunctions().increaseQuantity(
                                  widget.cartId,
                                  itemData['id'],
                                  itemData['quantity'],
                                  false);
                            },
                            child: Icon(
                              itemData['quantity'] != '1'
                                  ? FontAwesomeIcons.minusCircle
                                  : FontAwesomeIcons.trashAlt,
                              color: Colors.amber,
                              size: 17.5,
                            )),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          itemData['quantity'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await CartFunctions().increaseQuantity(
                                  widget.cartId,
                                  itemData['id'],
                                  itemData['quantity'],
                                  true);
                            },
                            child: Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.amber,
                              size: 17.5,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      '₹ ' +
                          CartFunctions().pricePerItem(
                            itemData['price'],
                            itemData['quantity'],
                          ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 11,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  couponWidget(bool hasCoupon, couponCode, minCouponValue, totalPrice, cartId) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.077,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.local_offer_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    hasCoupon == true && minCouponValue <= totalPrice
                        ? Text(
                            couponCode.toString(),
                            style: TextStyle(color: Colors.black),
                          )
                        : hasCoupon == true && minCouponValue > totalPrice
                            ? Text('Add More To cart')
                            : Text('Apply Coupn'),
                    hasCoupon == true
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () async {
                                  Provider.of<CartDataProvider>(context,
                                          listen: false)
                                      .removeCoupon(cartId);
                                },
                                child: Text(
                                  'Remove Coupon',
                                  textAlign: TextAlign.end,
                                )),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CouponScreen(
                                              totalPrice: totalPrice)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.arrow_right_sharp))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int calculateCouponDiscount(totalPrice, couponPercentage, maxDiscount) {
    double discount = ((couponPercentage / 100) * totalPrice);

    return discount < maxDiscount
        ? (totalPrice.toDouble() - discount).ceil()
        : totalPrice - maxDiscount;
  }

  @override
  void initState() {
    super.initState();

    // //calling cart data provider which provides all the relevent data for the cart
    // Provider.of<CartDataProvider>(context, listen: true)
    //     .getRestaurantData(widget.cartId);

    //Provides data for delivery location to the cart
    Provider.of<UserAddressProvider>(context, listen: false)
        .checkDefaultDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    //Provides total price for the items present in the cart
    Timer(const Duration(milliseconds: 300), () async {
      Provider.of<TotalPriceProvider>(context, listen: false)
          .getTotalPrice(widget.data);
    });

    context.read<CartDataProvider>().getRestaurantData(widget.cartId);
    return SafeArea(
      child: Container(
        child: Center(
            child: Consumer<CartDataProvider>(builder: (context, value, child) {
          return value.hasData == false
              ? CircularProgressIndicator(
                  color: Colors.yellow,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.network(value.restaurantData['FoodImage']),
                      title: Text(
                        value.restaurantData['Name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      subtitle: Text(
                        value.restaurantData['Address'],
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return menuItemWidget(widget.data[index].data());
                          }),
                    ),
                    Consumer<TotalPriceProvider>(
                        builder: (_, totalPriceValue, __) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Cart Total - ₹ ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(totalPriceValue.totalPriceProvider
                                    .toString())
                              ],
                            ),
                          ),
                          couponWidget(
                              value.hasCoupon,
                              value.couponCode,
                              value.minCouponValue,
                              totalPriceValue.totalPriceProvider,
                              widget.cartId)
                        ],
                      );
                    }),
                    Consumer<UserAddressProvider>(builder:
                        (context, userAddressValue, userAddressWidget) {
                      return userAddressValue.hasDeafultAddress
                          ? ListTile(
                              leading: Text(
                                  userAddressValue.addressData['category']),
                              title: Text(
                                  userAddressValue.addressData['house-feild']),
                              subtitle: Text(
                                  userAddressValue.addressData['street-feild']),
                              trailing: TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Address())).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Text('Change')),
                            )
                          : TextButton(
                              onPressed: () async {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return LocationBottomSheetWidget(
                                        isAddingAddress: true,
                                      );
                                    }).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Text('Add Address'));
                    }),
                    Consumer<TotalPriceProvider>(
                        builder: (context, totalPriceValue, payWidget) {
                      return Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.yellow.shade700,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Consumer<UserAddressProvider>(builder:
                              (context, userAddressValue, userAddressWidget) {
                            return GestureDetector(
                              onTap: () async {
                                userAddressValue.hasDeafultAddress == true
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RazorPayScreen(
                                                deliveryAddress:
                                                    userAddressValue
                                                        .addressData,
                                                finalPrice: calculateCouponDiscount(
                                                        totalPriceValue
                                                            .totalPriceProvider,
                                                        value.couponPercentage,
                                                        value.maxCouponDiscount)
                                                    .toDouble(),
                                                items: itemMap,
                                                cartId: widget.cartId,
                                                vednorId:
                                                    value.restaurantData['id'],
                                                vendorName: value
                                                    .restaurantData['Name'])))
                                    : showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return LocationBottomSheetWidget(
                                            isAddingAddress: true,
                                          );
                                        }).then((value) {
                                        setState(() {});
                                      });
                              },
                              child: Center(
                                child: value.hasCoupon &&
                                        value.minCouponValue <=
                                            totalPriceValue.totalPriceProvider
                                    ? Text(
                                        'Proceed To Pay ₹ ${calculateCouponDiscount(totalPriceValue.totalPriceProvider, value.couponPercentage, value.maxCouponDiscount).toString()}',
                                        style: TextStyle(
                                          color: Colors.yellow.shade700,
                                          fontSize: 15,
                                        ),
                                      )
                                    : Text(
                                        'Proceed To Pay ₹ ${totalPriceValue.totalPriceProvider}',
                                        style: TextStyle(
                                          color: Colors.yellow.shade700,
                                          fontSize: 15,
                                        ),
                                      ),
                              ),
                            );
                          }));
                    })
                  ],
                );
        })),
      ),
    );
  }
}
