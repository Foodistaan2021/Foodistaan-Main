import 'package:flutter/material.dart';
import 'package:foodistan/functions/order_functions.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class OrderHistoryWidget extends StatefulWidget {
  var orderData;
  OrderHistoryWidget({required this.orderData});

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  Widget itemsList(Map orderItems) {
    if (orderItems.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: orderItems.length,
          itemBuilder: (BuildContext context, int index) {
            String key = orderItems.keys.elementAt(index);
            String menuItem = key.replaceAll('-', ' ').toUpperCase();
            return Text("${orderItems[key]} X $menuItem",
                style: TextStyle(fontSize: 12));
          });
    } else
      return Text('Some Eror');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.5,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(11),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage('assets/images/dosa.png'),
                              // image: CachedNetworkImageProvider('assets/images/dosa.png'),

                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 75,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderData['vendor-name'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Rohini, New Delhi',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\u{20B9}${widget.orderData['total-bill'].toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       widget.orderData['total-bill'].toString(),
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 11,
            //     ),
            //   ],
            // ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  itemsList(widget.orderData['items']),
                  const SizedBox(
                    height: 5,
                  ),

                  // Text(
                  //   '1x Masala Dosa',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ordered On',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          OrderFunction().orderTime(widget.orderData['time']),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Status: ${widget.orderData['order-status']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 252, 222, 1),
                borderRadius: BorderRadius.circular(11),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(223, 195, 11, 1),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        'You Rated',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.011,
                          bottom: MediaQuery.of(context).size.width * 0.011,
                          left: MediaQuery.of(context).size.width * 0.005,
                          right: MediaQuery.of(context).size.width * 0.005,
                        ),
                        // height: 20,
                        width: MediaQuery.of(context).size.width * 0.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(247, 193, 43, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.005,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(247, 193, 43, 1),
                          ),
                          child: Icon(
                            Icons.refresh,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Repeat Order',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
