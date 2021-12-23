import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/cart_screens/total_price_screen.dart';

class CouponScreen extends StatefulWidget {
  var cartId;
  var totalPrice;
  CouponScreen({required this.cartId, required this.totalPrice});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  List coupons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncGetCoupons().then((value) {
      setState(() {
        coupons = value;
      });
    });
  }

  asyncGetCoupons() async {
    List coupons = [];
    final CollectionReference couponsList =
        await FirebaseFirestore.instance.collection('coupons');

    try {
      await couponsList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              coupons.add(element.data());
            })
          });
    } catch (e) {
      print(e.toString());
    }
    return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Select Coupon'),
      ),
      body: coupons.isEmpty
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: coupons.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> couponData = coupons[index];
                return Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Coupon Code'),
                        Text(
                            'Get ${couponData['percentage']}% off upto ${couponData['max-discount']}'),
                        Text(
                            'Valid on orders with items worth Rs. ${couponData['min-price']}'),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            couponData['code'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: TextButton(
                              onPressed: () async {
                                if (widget.totalPrice <
                                    couponData['min-price']) {
                                  return null;
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(widget.cartId)
                                      .update({
                                    'coupon-id': couponData['id']
                                  }).then((value) {
                                    couponCode = couponData['code'];
                                    maxCouponDiscount =
                                        couponData['max-discount'];
                                    couponPercentage.value =
                                        couponData['percentage'];

                                    Navigator.pop(context);
                                  });
                                }
                              },
                              child: Text('Apply')),
                          subtitle: widget.totalPrice < couponData['min-price']
                              ? Text('Add items worth Rs.' +
                                  ( couponData['min-price']-widget.totalPrice)
                                      .toString() +
                                  ' to avail this offer')
                              : Text('You will save ' +
                                  (widget.totalPrice *
                                          (couponData['percentage'] / 100))
                                      .toString() +
                                  ' with this coupon'),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    ));
  }
}
