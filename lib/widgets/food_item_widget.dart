import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:foodistan/functions/cart_functions.dart';

class MyFoodItemWidget extends StatefulWidget {
  static String id = 'my_food_widget';
  var menu_item;
  String vendor_id, cartId, vendorName;
  MyFoodItemWidget(
      {required this.menu_item,
      required this.vendor_id,
      required this.cartId,
      required this.vendorName});

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network('${widget.menu_item['image']}'),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
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
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Text("${widget.menu_item['description']}",
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text("₹ ${widget.menu_item['price']}",
                      maxLines: 3,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            child: CartFunctions().quantityWidgetInRestaurant(
                widget.cartId,
                widget.menu_item['id'],
                widget.vendor_id,
                widget.menu_item,
                widget.vendorName),
          )
        ],
      ),
    );
  }
}
