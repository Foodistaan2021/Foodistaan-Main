import 'package:flutter/material.dart';
import 'package:foodistan/widgets/food_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> fetchMenu(vendor_id) async {
  List menu_items = [];
  final CollectionReference MenuItemsList = FirebaseFirestore.instance
      .collection('DummyData')
      .doc(vendor_id)
      .collection('menu-items');
  try {
    await MenuItemsList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            menu_items.add(element.data());
          })
        });
  } catch (e) {
    print(e.toString());
  }

  return menu_items;
}

class RestuarantDeliveryMenu extends StatefulWidget {
  String vendor_id;
  RestuarantDeliveryMenu({required this.vendor_id});

  @override
  _RestuarantDeliveryMenuState createState() => _RestuarantDeliveryMenuState();
}

class _RestuarantDeliveryMenuState extends State<RestuarantDeliveryMenu> {
  List menu_items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMenu(widget.vendor_id).then((value) {
      setState(() {
        menu_items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.32;

    return Scaffold(
      body: Column(
        children: [
        

          Container(
              child: menu_items.isEmpty
                  ? CircularProgressIndicator()
                  : GridView.count(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      children: List.generate(menu_items.length, (index) {
                        return MyFoodItemWidget(
                          menu_item: menu_items[index],vendor_id : widget.vendor_id,
                        );
                      }),
                    )),
        ],
      ),
    );
  }
}
