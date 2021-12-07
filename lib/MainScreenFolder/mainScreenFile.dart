import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'package:foodistan/widgets/order_placed_screen.dart';
import 'AppBar/AppBarFile.dart';
import 'Test.dart';
import 'HomeScreenFile.dart';
import 'package:foodistan/Data/data.dart';
import 'Location/LocationMap.dart';
import 'AppBar/LocationPointsSearch.dart';

var currentLocation = null;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  int currentIndex = 0;
  int inx = 0;
  bool once = false;
  String? userNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    });
  }

  var Screens = [
    HomeScreen(
      myCurrentLocation: currentLocation,
    ), //HomeScreenFile
    CartScreenMainLogin(),
    BufferScreen(),
    UserProfile(),
  ];
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey.shade900,
          selectedItemColor: Color.fromRGBO(247, 193, 43, 1),
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'Images/home.png',
                height: 22,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Images/cart.png',
                height: 22,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Images/scan.png',
                height: 22,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'Images/profile.png',
                height: 22,
              ),
              label: 'Profile',
            ),
          ],
        ),
        appBar: currentIndex == 0
            ? PreferredSize(
                preferredSize:
                    Size.fromHeight(h1 * 0.12), // here the desired height
                child: SafeArea(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        height: h1 / 32,
                        width: w1,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddLocation(),
                                      ),
                                    );
                                  },
                                  child: Location(),
                                )),
                            Expanded(flex: 1, child: Points()),
                          ],
                        ),
                      ),
                    ),
                    Search(
                      searchTask: () {
                        showSearch(
                            context: context,
                            delegate: DataSearch(file: Data.restaurants));
                      },
                    ),
                  ]),
                ),
              )
            : null,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Images/BgSmiley.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Screens[currentIndex]),
            userNumber != ''
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: OrderFunction().fetchCurrentOrder(userNumber),
                    ),
                  )
                : Center(),
          ],
        ),
      ),
    );
  }
}
