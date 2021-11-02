import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/profile/foodistaan_pro.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'AppBarFile.dart';
import 'Test.dart';
import 'HomeScreenFile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  int currentIndex = 0;
  var Screens = [
    HomeScreen(), //HomeScreenFile
    CartScreenMainLogin(),
    BufferScreen(),
    UserProfile(),
  ];
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xff0E1829),
        selectedItemColor: Color(0xffFAC05E),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profile',
          ),
        ],
      ),
      appBar: currentIndex == 0
          ? PreferredSize(
              preferredSize:
                  Size.fromHeight(h1 / 6.8), // here the desired height
              child: MainScreenAppBar(),
            )
          : null,
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Images/BgSmiley.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Screens[currentIndex]),
    );
  }
}
