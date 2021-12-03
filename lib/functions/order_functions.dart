import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/accepted_order.dart';
import 'package:foodistan/widgets/order_history_widget.dart';

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
}
