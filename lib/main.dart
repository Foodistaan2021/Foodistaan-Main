import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodistan/profile/profile_address.dart';
import 'package:foodistan/providers/cart_id_provider.dart';
import 'package:foodistan/providers/restaurant_data_provider.dart';
import 'package:foodistan/providers/total_price_provider.dart';
import 'package:foodistan/providers/user_address_provider.dart';
import 'package:provider/provider.dart';
import 'scanner.dart';
import 'MainScreenFolder/mainScreenFile.dart';
import 'optionScreenFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';

void main() async {
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CartIdProvider>(
              create: (_) => CartIdProvider()),
          ChangeNotifierProvider<RestaurantDataProvider>(
              create: (_) => RestaurantDataProvider()),
          ChangeNotifierProvider<TotalPriceProvider>(
              create: (_) => TotalPriceProvider()),
          ChangeNotifierProvider<UserAddressProvider>(
              create: (_) => UserAddressProvider())
        ],
        builder: (context, child) {
          return MaterialApp(
            initialRoute: FirebaseAuth.instance.currentUser != null ? 'H' : 'L',
            routes: {
              'S': (context) => ScannerScreen(),
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
        });
  }
}
