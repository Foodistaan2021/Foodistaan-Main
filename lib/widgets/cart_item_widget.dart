import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> fetchItem(vendor_id, menu_item) async {
  List item_list = [];
  var document = FirebaseFirestore.instance
      .collection('DummyData')
      .doc(vendor_id)
      .collection('menu-items')
      .where('id', isEqualTo: menu_item);
  try {
    await document.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            item_list.add(element.data());
          })
        });
  } catch (e) {
    print(e.toString());
  }
  return item_list;
}

class CartItem extends StatefulWidget {
  String vendor_id;
  String menu_item_id;
  CartItem({required this.menu_item_id, required this.vendor_id});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map<String, dynamic> menu_item = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItem(widget.vendor_id, widget.menu_item_id).then((value) {
      setState(() {
        menu_item = value[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return menu_item.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            height: MediaQuery.of(context).size.height * 0.22,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          children: [
                            Image.asset('assets/images/green_sign.png'),
                            Column(
                              children: [
                                Text(menu_item['title']),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextButton(onPressed: null, child: Text("-")),
                                Text("1"),
                                TextButton(onPressed: null, child: Text("+")),
                              ],
                            ),
                            Text(menu_item['price'])
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
