import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/accepted_order.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedScreen extends StatefulWidget {
  String vendorName, orderId;
  OrderPlacedScreen({required this.vendorName, required this.orderId});

  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _animationComplete = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationComplete = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'H');
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                child: Lottie.asset('Images/lf20_1mskailz.json',
                    repeat: false,
                    controller: _controller, onLoaded: (compostion) {
                  _controller.forward();
                }),
              ),
              SizedBox(
                height: 20,
              ),
              _animationComplete
                  ? Container(
                      child: Text("Order Placed",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)))
                  : Container(),
              SizedBox(
                height: 10,
              ),
              _animationComplete
                  ? Text(
                      "Thanks for ordering. Your order will be at your doorsteps shortly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.normal))
                  : Container(),
              SizedBox(
                height: 50,
              ),
              _animationComplete
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Color(0xFFF)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFF7C12B)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ))),
                        onPressed: () async {
                          await OrderFunction()
                              .fetchOrderData(widget.orderId)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AcceptedOrder(orderData: value)));
                          });
                        },
                        child: Text(
                          'Track Order',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
