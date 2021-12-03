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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset('Images/lf20_1mskailz.json',
                  repeat: false,
                  controller: _controller, onLoaded: (compostion) {
                _controller.forward();
              }),
              _animationComplete
                  ? Container(
                      child: Text("Order Placed",
                          style: TextStyle(
                              color: Color(0xfff7c12b),
                              fontSize: 24,
                              fontWeight: FontWeight.bold)))
                  : Container(),
              _animationComplete
                  ? Container(
                      child: Text("At ${widget.vendorName} ${widget.orderId}",
                          style: TextStyle(
                              color: Color(0xfff7c12b),
                              fontSize: 24,
                              fontWeight: FontWeight.normal)))
                  : Container(),
              _animationComplete
                  ? ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFFF)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF7C12B)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
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
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
