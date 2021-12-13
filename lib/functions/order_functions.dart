import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/accepted_order.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/widgets/order_history_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderFunction {
  final _firestore = FirebaseFirestore.instance;
  placeOrder(vendorId, vendorName, userNumber, items, totalPrice, paymentId,
      cartId) async {
    String id = _firestore.collection('live-orders').doc().id;
    DateTime time = DateTime.now();
    await _firestore.collection('live-orders').doc(id).set({
      'vendor-id': vendorId,
      'vendor-name': vendorName,
      'order-id': id,
      'items': items,
      'total-bill': totalPrice,
      'order-status': 'preparing',
      'customer-id': userNumber,
      'time': time,
      'payment-id': paymentId,
    }).then((value) {
      _firestore
          .collection('users')
          .doc(userNumber)
          .collection('orders')
          .doc(id)
          .set({
        'vendor-id': vendorId,
        'vendor-name': vendorName,
        'order-id': id,
        'items': items,
        'total-bill': totalPrice,
        'order-status': 'preparing',
        'time': time,
        'payment-id': paymentId,
        'live-order': true,
      });
    });

    await _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .get()
        .then((snapshots) {
      for (var item in snapshots.docs) {
        item.reference.delete();
      }
    });
    return id;
  }

  fetchOrderData(orderId) async {
    var orderData;
    await _firestore.collection('live-orders').doc(orderId).get().then((value) {
      orderData = value;
    });
    return orderData;
  }

  Widget fetchAllOrders(userNumber) {
    ScrollController _controller = ScrollController();
    var stream = _firestore
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text('Fetching Orders'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return Center(
                    child: Text('No Orders Yet'),
                  );
                else {
                  return ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AcceptedOrder(
                                      orderData: snapshot.data!.docs[index]))),
                          child: OrderHistoryWidget(
                              orderData: snapshot.data!.docs[index].data()),
                        );
                      });
                }
              } else
                return Center(
                  child: Text('Error'),
                );
          }
        });
  }

  orderTime(timeStamp) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    final Timestamp timestamp = timeStamp;
    final date = timestamp.toDate().day.toString();
    final month = monthNames[timestamp.toDate().month - 1];
    final year = timestamp.toDate().year.toString();
    final hour = timestamp.toDate().hour.toString();
    final minutes = timestamp.toDate().minute.toString();

    return '$month $date, $year at $hour : $minutes';
  }

  Widget fetchCurrentOrder(userNumber) {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .where('live-order', isEqualTo: true)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasData) {
                int totalDocs = snapshot.data!.docs.length;
                if (totalDocs > 0)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        bool onlyOneOrder = totalDocs == 1 ? true : false;
                        var orderData = snapshot.data!.docs.first;
                        return GestureDetector(
                          onTap: () {
                            onlyOneOrder
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AcceptedOrder(
                                            orderData: orderData)))
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Orders()));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 1,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 10, 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 4,
                                                child: SvgPicture.asset(
                                                  'Images/foodpreparing.svg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      2,
                                                )),
                                            Expanded(
                                              flex: 6,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  onlyOneOrder
                                                      ? Text(
                                                          orderData[
                                                                  'order-status']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          'Preparing Your Orders',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                  if (onlyOneOrder)
                                                    Text(orderData[
                                                        'vendor-name'])
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xFFF7C12B)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xFFF)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                            )),
                                          ),
                                          onPressed: null,
                                          child: onlyOneOrder
                                              ? Text('Track Order')
                                              : Text('Track All Orders')))
                                ],
                              )),
                        );
                      });
                else
                  return Center();
              } else {
                return Center();
              }
          }
        });
  }
}
