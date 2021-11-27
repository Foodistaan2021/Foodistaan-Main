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
      appBar: AppBar(
        title: Text('Lottie'),
      ),
      body: Center(
        child: Column(
          children: [
            Lottie.asset('Images/food-animation.json'),
          ],
        ),
      ),
    );
  }
}
