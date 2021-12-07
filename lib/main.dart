import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/pay_cart_screen_main.dart';
import 'package:foodistan/functions/razorpay_integration.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/widgets/order_placed_screen.dart';
import 'bufferScreenFile.dart';
import 'MainScreenFolder/mainScreenFile.dart';
import 'optionScreenFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: FirebaseAuth.instance.currentUser != null ? 'H' : 'L',
    // initialRoute: 'R',
    routes: {
      'B': (context) => BufferScreen(),
      'L': (context) => LoginScreen(),
      'H': (context) => MainScreen(),
      'O': (context) => OptionScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
