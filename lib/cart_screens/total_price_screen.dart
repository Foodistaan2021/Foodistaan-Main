import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalPrice extends StatefulWidget {
  String user_number;
  TotalPrice({required this.user_number});

  @override
  _TotalPriceState createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  getPrice(Map cartTotal) {
    var price = 0;
    if (cartTotal.isNotEmpty) {
      cartTotal.forEach((i, value) {
        price += value as int;
      });
    }
    print(price);
    return price;
  }

  Widget totalPrice() {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: widget.user_number)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Waiting-1'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text('Waiting-1'),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map cartTotal =
                            snapshot.data!.docs[index]['cart-total-map'];
                        var price = getPrice(cartTotal);

                        return cartTotal.isEmpty
                            ? Center(
                                child: Text('No-Data'),
                              )
                            : Column(children: [
                                Text('Billing Details'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Item Total'),
                                    Text(price.toString())
                                  ],
                                ),
                              ]);
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
    return totalPrice();
  }
}
