import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodistan/MainScreenFolder/accepted_order.dart';
import 'package:foodistan/profile/your_orders.dart';

class CurrentOrderBottomWidget extends StatefulWidget {
  CurrentOrderBottomWidget({Key? key}) : super(key: key);

  @override
  State<CurrentOrderBottomWidget> createState() =>
      _CurrentOrderBottomWidgetState();
}

class _CurrentOrderBottomWidgetState extends State<CurrentOrderBottomWidget> {
  bool isTrue = false;

  Widget bottomWidget(orderData, totalCount) {
    bool onlyOneOrder = totalCount == 1 ? true : false;

    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: SvgPicture.asset(
                            'Images/foodpreparing.svg',
                            width: MediaQuery.of(context).size.width * 2,
                          )),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            onlyOneOrder
                                ? Text(
                                    orderData['order-status']
                                        .toString()
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    'Preparing Your Orders',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            if (onlyOneOrder) Text(orderData['vendor-name'])
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  0, 8, MediaQuery.of(context).size.width * 0.18, 8),
              child: Expanded(
                  flex: 2,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFF7C12B)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFF)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        )),
                      ),
                      onPressed: () {
                        if (onlyOneOrder) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AcceptedOrder(orderData: orderData)));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Orders()));
                        }
                      },
                      child: onlyOneOrder
                          ? Text('Track Order')
                          : Text('Track All Orders'))),
            )
          ],
        ));
  }

  fetchCurrentOrder() {
    var userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .where('live-order', isEqualTo: true)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            int totalDocs = snapshot.data!.docs.length;
            if (totalDocs == 1)
              return bottomWidget(snapshot.data!.docs.first, totalDocs);
            else if (totalDocs > 1) {
              return bottomWidget(snapshot.data!.docs.first, totalDocs);
            } else
              return Container(
                height: 0,
              );
          } else {
            return Container(
              height: 0,
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return fetchCurrentOrder();
  }
}
