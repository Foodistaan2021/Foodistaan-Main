import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/cart_screens/total_price_screen.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readmore/readmore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreenMainLogin extends StatefulWidget {
  static String id = 'cart_screen';

  @override
  _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin> {
  ScrollController _controller = ScrollController();
  String user_number = '';

// FETCHES MULTIPLE RESTAURANTS LIST FROM CART OF A USER

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
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'H');
                        },
                        child: Text('Add Items to Cart')),
                  );
                else {
                  return ListView.builder(
                      controller: _controller,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String id = snapshot.data!.docs[index].id;
                        return RestaurantInCartWidget(
                          vendor_id: id,
                          userNumber: userNumber,
                        );
                      });
                }
              } else {
                return Center(
                  child: Text('No Data'),
                );
              }
          }
        });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      user_number = AuthMethod().checkUserLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Color.fromRGBO(247, 193, 43, 1),
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            user_number == ''
                ? Center(
                    child: Text('Hello'),
                  )
                : cartItems(user_number),
            TotalPrice(user_number: user_number)
          ],
        ),
      ) // CALLS THE FUNCTION ON BASIS OF USER LOGIN
          ),
    );
  }
}

class RestaurantInCartWidget extends StatefulWidget {
  String vendor_id;
  String userNumber;
  RestaurantInCartWidget({required this.vendor_id, required this.userNumber});

  @override
  _RestaurantInCartWidgetState createState() => _RestaurantInCartWidgetState();
}

class _RestaurantInCartWidgetState extends State<RestaurantInCartWidget> {
  @override
  DocumentSnapshot? items;
  bool hasData = false;
  void initState() {
    super.initState();

    CartFunctions().fetchRestaurantsInCart(widget.vendor_id).then((value) {
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
            padding: EdgeInsets.all(10),
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
                    title: Text(
                      items!['Name'],
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    subtitle: Text(items!['Address']),
                  ),
                  Padding(
                    padding: EdgeInsets.all(13),
                    child: CartItemsList(
                      userNumber: widget.userNumber,
                      vendor_id: widget.vendor_id,
                    ),
                  ),
                ],
              ),
            ))
        : CircularProgressIndicator();
  }
}

//Fetches cart items in the particular restaurant

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
                        var qauntity = snapshot.data!.docs[index]['quantity'];

                        return Center(
                          child: ItemsInCartWidget(
                            itemId: id,
                            vendor_id: vendor_id,
                            quantity: qauntity,
                            user_number: user_number,
                            index: index,
                          ),
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

class ItemsInCartWidget extends StatefulWidget {
  String vendor_id;
  String itemId;
  var quantity;
  String user_number;
  int index;
  ItemsInCartWidget(
      {required this.itemId,
      required this.vendor_id,
      required this.quantity,
      required this.user_number,
      required this.index});

  @override
  _ItemsInCartWidgetState createState() => _ItemsInCartWidgetState();
}

class _ItemsInCartWidgetState extends State<ItemsInCartWidget> {
  Map? menu_item_data;
  bool hasData = false;

  @override
  void initState() {
    super.initState();

    CartFunctions()
        .fetchMenuItem(widget.vendor_id, widget.itemId)
        .then((value) {
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
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        menu_item_data!['veg'] == true
                            ? Image.asset('assets/images/green_sign.png')
                            : Image.asset('assets/images/red_sign.png'),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          menu_item_data!['title'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await CartFunctions().changeQuantity(
                                    widget.vendor_id,
                                    widget.itemId,
                                    false,
                                    widget.quantity,
                                    widget.user_number);
                                await CartFunctions().getSomething(
                                    widget.user_number,
                                    widget.itemId,
                                    widget.quantity,
                                    menu_item_data!['price'],
                                    widget.vendor_id);
                              },
                              icon: Icon(
                                FontAwesomeIcons.minusCircle,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                            Text(widget.quantity.toString()),
                            IconButton(
                              onPressed: () async {
                                await CartFunctions().changeQuantity(
                                    widget.vendor_id,
                                    widget.itemId,
                                    true,
                                    widget.quantity,
                                    widget.user_number);

                                await CartFunctions().getSomething(
                                    widget.user_number,
                                    widget.itemId,
                                    widget.quantity,
                                    menu_item_data!['price'],
                                    widget.vendor_id);
                              },
                              icon: Icon(
                                FontAwesomeIcons.plusCircle,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                            Text('Rs. ' +
                                CartFunctions()
                                    .getPrice(menu_item_data!['price'],
                                        widget.quantity)
                                    .toString())
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        : CircularProgressIndicator();
  }
}
