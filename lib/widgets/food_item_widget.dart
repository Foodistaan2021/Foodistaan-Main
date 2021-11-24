import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'dart:math' as math;
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/MainScreenFolder/ListingsFile.dart';

class MyFoodItemWidget extends StatefulWidget {
  static String id = 'my_food_widget';
  var menu_item;
  String vendor_id;
  MyFoodItemWidget({required this.menu_item, required this.vendor_id});

  @override
  _MyFoodItemWidgetState createState() => _MyFoodItemWidgetState();
}

class _MyFoodItemWidgetState extends State<MyFoodItemWidget> {
  String? user_number;

  @override
  void initState() {
    super.initState();
    user_number = AuthMethod().checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network('${widget.menu_item['image']}'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text('${widget.menu_item['title']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text("${widget.menu_item['description']}",
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text("Rs. ${widget.menu_item['price']}",
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('ADD'),
            style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              onPrimary: Colors.white,
              shadowColor: Colors.red,
              elevation: 5,
            ),
            onPressed: () async {
              String text = await CartFunctions().addItemToCart(
                  user_number, widget.menu_item['id'], widget.vendor_id,widget.menu_item['price']);

              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(text),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          )
        ],
      ),
    );
  }
}
