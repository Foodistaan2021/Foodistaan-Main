import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';

void main() async {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        initialRoute: FirebaseAuth.instance.currentUser != null ? 'H' : 'L',
        routes: {
          'B': (context) => BufferScreen(),
          'L': (context) => LoginScreen(),
          'H': (context) => MainScreen(),
          'O': (context) => OptionScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Foodistaan',
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: Colors.yellow.shade700,
        ),
      );
  }
}
