import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class OrderPlacedScreen extends StatefulWidget {
  const OrderPlacedScreen({Key? key}) : super(key: key);

  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            Lottie.asset('Images/food-animation.json'),
            Container(
                child: Text("Order Placed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: 30,
            ),
            Container(
                child: Text("At Gupta Burger",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.normal))),
          ],
        ),
      ),
    );
  }
}
