import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'package:foodistan/widgets/current_order_bottom_widget.dart';
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
    return Scaffold(
      bottomSheet: CurrentOrderBottomWidget(),
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
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, w1 / 40, 0),
                                child: Points(),
                              )),
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
