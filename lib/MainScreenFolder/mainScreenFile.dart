import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import '../scanner.dart';
import 'AppBar/AppBarFile.dart';
import 'HomeScreenFile.dart';
import 'package:foodistan/Data/data.dart';
import 'AppBar/LocationPointsSearch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

//Main screen contains bottom nav bar
//which contains all the main screens

class MainScreen extends StatefulWidget {
  int currentIndex;
  MainScreen({this.currentIndex = 0});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var screens = [
    HomeScreen(), //HomeScreenFile
    CartScreenMainLogin(),
    ScannerScreen(),
    UserProfile(),
  ];

  Widget build(BuildContext context) {
    final Color selected = Color.fromRGBO(247, 193, 43, 1);
    final Color unselected = Colors.grey;
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
          activeColor: selected,
          inactiveColor: unselected,
          enableShadow: true,
          currentIndex: widget.currentIndex,
          onTap: (index) => setState(() {
                widget.currentIndex = index;
                _pageController.jumpToPage(widget.currentIndex);
              }),
          // type: BottomNavigationBarType.fixed,
          // iconSize: 16,
          // unselectedItemColor: unselected,
          // selectedItemColor: selected,
          // backgroundColor: Colors.white,
          // showUnselectedLabels: false,
          // showSelectedLabels: true,
          // elevation: 0,
          items: [
            TitledNavigationBarItem(title: Text('Home'), icon: Icons.home),
            TitledNavigationBarItem(
                title: Text('Cart'), icon: Icons.shopping_bag),
            TitledNavigationBarItem(
                title: Text('Scan'), icon: Icons.fit_screen),
            TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person)
          ]
          // items: [
          //   TitledNavigationBarItem(
          //     icon: SvgPicture.asset(
          //       'Images/bottomhome.svg',
          //       color: widget.currentIndex == 0 ? selected : unselected,
          //     ),
          //     title: Text("Home"),
          //   ),
          //   TitledNavigationBarItem(
          //     icon: SvgPicture.asset(
          //       'Images/bottomcart.svg',
          //       color: widget.currentIndex == 1 ? selected : unselected,
          //     ),
          //     title: Text("Cart"),
          //   ),
          //   TitledNavigationBarItem(
          //     icon: SvgPicture.asset(
          //       'Images/bottomscan.svg',
          //       color: widget.currentIndex == 2 ? selected : unselected,
          //     ),
          //     title: Text("Scan"),
          //   ),
          //   TitledNavigationBarItem(
          //     icon: SvgPicture.asset(
          //       'Images/bottomprofile.svg',
          //       color: widget.currentIndex == 3 ? selected : unselected,
          //     ),
          //     title: 'PrText("file"),
          //   ),
          // ],
          ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: screens,
          ),

          //Checks if any current orders exists for the current user
          //uses Stream Builder for live updates
          //returns a widget like a bottom NAVBAR
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OrderFunction().fetchCurrentOrder(userNumber),
            ),
          )
        ],
      ),
    );
  }
}
