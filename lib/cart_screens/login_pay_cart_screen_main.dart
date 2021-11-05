import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/cart_screens/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/widgets/cart_item_widget.dart';

class CartScreenMainLogin extends StatefulWidget {
  static String id = 'cart_screen';

  @override
  _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin> {
  ScrollController _controller = ScrollController();
  String user_number = '';

  Widget cartItems(userNumber) {
    var cartStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('cart')
        .snapshots();
    return StreamBuilder(
        stream: cartStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('waiting-1'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('waiting-2'),
                  );
                else {
                  return ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id = snapshot.data!.docs[index].id;
                        return Center(
                            child: RestaurantCartWidget(
                          vendor_id: id,
                          userNumber: userNumber,
                        ));
                      });
                }
              } else {
                return Center(
                  child: Text('No Data'),
                );
              }
          }
        });

    // return Container(
    //   padding: EdgeInsets.all(10),
    //   // decoration:
    //   //     BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
    //   height: MediaQuery.of(context).size.height * 0.25,
    //   child: Center(
    //     child: StreamBuilder(
    //         stream: cartStream,
    //         builder: (BuildContext context,S snapshot) {
    //           return snapshot.hasData
    //               ? ListView.builder(
    //                   itemCount: (snapshot.data.docs as QuerySnapshot).docs.length,
    //                   itemBuilder: (context, index) {
    //                     DocumentSnapshot ds =
    //                         (snapshot.data! as QuerySnapshot).docs[index];
    //                     print(ds.exists);
    //                     return Center(
    //                       child: Text('Hello'),
    //                       // child: CartItem(
    //                       //     menu_item_id: ds['menu_item_id'],
    //                       //     vendor_id: ds['vendor_id']),
    //                     );
    //                   })
    //               : Center(child: Text('Cart Empty'));
    //         }),
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user_number = AuthMethod().checkUserLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(247, 193, 43, 1),
          title: Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          child: user_number == ''
              ? Center(
                  child: Text('Hello'),
                )
              : cartItems(user_number),
        ));
  }
}

class RestaurantCartWidget extends StatefulWidget {
  String vendor_id;
  String userNumber;
  RestaurantCartWidget({required this.vendor_id, required this.userNumber});

  @override
  _RestaurantCartWidgetState createState() => _RestaurantCartWidgetState();
}

class _RestaurantCartWidgetState extends State<RestaurantCartWidget> {
  @override
  DocumentSnapshot? items;
  bool hasData = false;
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchRestaurantsInCart(widget.vendor_id).then((value) {
      setState(() {
        items = value;
        hasData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasData
        ? Container(
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))),
            // height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Image.network(items!['FoodImage']),
                    title: Text(items!['Name']),
                    subtitle: Text(items!['Address']),
                  ),
                  CartItemsList(
                    userNumber: widget.userNumber,
                    vendor_id: widget.vendor_id,
                  ),
                ],
              ),
            ))
        : CircularProgressIndicator();
  }
}

class CartItemsList extends StatefulWidget {
  String userNumber;
  String vendor_id;
  CartItemsList({required this.userNumber, required this.vendor_id});

  @override
  _CartItemsListState createState() => _CartItemsListState();
}

class _CartItemsListState extends State<CartItemsList> {
  Widget cartItems(vendor_id, user_number) {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(user_number)
        .collection('cart')
        .doc(vendor_id)
        .collection('cart-items')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('waiting-1'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('waitng-1'),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id = snapshot.data!.docs[index].id;
                        return Center(
                          child: ActualCartItemsWidget(
                              itemId: id, vendor_id: vendor_id),
                        );
                      });
                }
              } else {
                return Center(
                  child: Text('No-Data'),
                );
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return cartItems(widget.vendor_id, widget.userNumber);
  }
}

class ActualCartItemsWidget extends StatefulWidget {
  String vendor_id;
  String itemId;
  ActualCartItemsWidget({required this.itemId, required this.vendor_id});

  @override
  _ActualCartItemsWidgetState createState() => _ActualCartItemsWidgetState();
}

class _ActualCartItemsWidgetState extends State<ActualCartItemsWidget> {
  Map? menu_item_data;
  bool hasData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchMenuItem(widget.vendor_id, widget.itemId).then((value) {
    //   setState(() {
    //     menuItems = value;
    //     hasData = true;
    //   });
    // });

    fetchMenuItem(widget.vendor_id, widget.itemId).then((value) {
      setState(() {
        menu_item_data = value;
        hasData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasData
        ? Container(
            child: ListTile(
              leading: menu_item_data!['veg'] == true
                  ? Image.asset('assets/images/green_sign.png')
                  : Image.asset('assets/images/red_sign.png'),
              title: Text(menu_item_data!['title']),
              trailing: Text(menu_item_data!['price']),
            ),
          )
        : CircularProgressIndicator();
  }
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
