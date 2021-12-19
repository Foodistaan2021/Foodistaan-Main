import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/cart_functions.dart';

class TotalBillBottomWidget extends StatefulWidget {
  const TotalBillBottomWidget({Key? key}) : super(key: key);

  @override
  _TotalBillBottomWidgetState createState() => _TotalBillBottomWidgetState();
}

class _TotalBillBottomWidgetState extends State<TotalBillBottomWidget> {
  String? userNumber;
  String cartId = '';
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    CartFunctions().getCartId(userNumber).then((value) {
      setState(() {
        cartId = value;
        stream = FirebaseFirestore.instance
            .collection('cart')
            .doc(cartId)
            .collection('items')
            .snapshots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return cartId == ''
        ? CircularProgressIndicator()
        : StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length != 0) {
                  var itemsNumber = snapshot.data!.docs.length;
                  return Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.green,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("$itemsNumber Items in the Cart",
                                  style: TextStyle(color: Colors.white)),
                              Text("Extra charges may apply",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: GestureDetector(
                              onTap: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => CartScreenMainLogin()));
                              },
                              child: Text("VIEW BILL",
                                  style: TextStyle(color: Colors.white))),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center();
                }
              } else
                return Center();
            });
  }
}
