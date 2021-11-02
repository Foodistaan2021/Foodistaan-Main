import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'dart:math' as math;
import 'package:foodistan/cart_screens/cart_functions.dart';
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
    return Material(
      child: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.48,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
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
                            Text('${widget.menu_item['title']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text("${widget.menu_item['description']}",
                          style: TextStyle(fontSize: 8)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Rs ${widget.menu_item['price']}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.12,
                        height: MediaQuery.of(context).size.height * 0.03,
                        color: Colors.red,
                        child: ElevatedButton(
                            onPressed: () async {
                              String text = await CartFunctions().addItemToCart(
                                  user_number,
                                  widget.menu_item['id'],
                                  widget.vendor_id);

                              final snackBar = SnackBar(
                                content: Text(text),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Center(
                              child: Text(
                                "Add",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
