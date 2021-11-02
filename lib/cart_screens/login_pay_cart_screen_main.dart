import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/cart_screens/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/widgets/cart_item_widget.dart';

class CartScreenMainLogin extends StatefulWidget {
  static String id = 'cart_screen';

  @override
  _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin> {
  String user_number = '';

  Widget cartItems(userNumber) {
    Stream cartStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('cart')
        .snapshots();
    return StreamBuilder(
        stream: cartStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds =
                        (snapshot.data! as QuerySnapshot).docs[index];
                    return Center(
                      child:CartItem(menu_item_id: ds['menu_item_id'], vendor_id: ds['vendor_id']),
                    );
                  })
              : Center(child: Text('Cart Empty'));
        });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      user_number = AuthMethod().checkUserLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(247, 193, 43, 1),
          title: Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            user_number == ''
                ? Center(
                    child: Text('Hello'),
                  )
                : cartItems(user_number),
          ],
        )
        // body: Column(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //           border: Border(bottom: BorderSide(color: Colors.grey))),
        //       height: MediaQuery.of(context).size.height * 0.22,
        //       child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Row(
        //               children: [
        //                 Image.asset('assets/images/reviewer.png'),
        //                 Column(
        //                   children: [
        //                     Text("Anna’s hut "),
        //                     Text("Rohini, Delhi"),
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.6,
        //                   child: Row(
        //                     children: [
        //                       Image.asset('assets/images/green_sign.png'),
        //                       Column(
        //                         children: [
        //                           Text("Garlic mix munchao Noodles"),
        //                           Text("vegies, less spice, 3 mayo"),
        //                           Text("Customize"),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.4,
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           TextButton(onPressed: null, child: Text("-")),
        //                           Text("1"),
        //                           TextButton(onPressed: null, child: Text("+")),
        //                         ],
        //                       ),
        //                       Text("₹120")
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.6,
        //                   child: Row(
        //                     children: [
        //                       Image.asset('assets/images/red_sign.png'),
        //                       Column(
        //                         children: [
        //                           Text("Chicken tandoori Momos (4 ps)"),
        //                           Text("2 mayos, 3 red chillie sauce"),
        //                           Text("Customize"),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.4,
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           TextButton(onPressed: null, child: Text("-")),
        //                           Text("1"),
        //                           TextButton(onPressed: null, child: Text("+")),
        //                         ],
        //                       ),
        //                       Text("₹120")
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(),
        //       height: MediaQuery.of(context).size.height * 0.22,
        //       child: Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Row(
        //               children: [
        //                 Image.asset('assets/images/reviewer.png'),
        //                 Column(
        //                   children: [
        //                     Text("Duriyodhan ka dhaba"),
        //                     Text("Vikaspuri, Delhi"),
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.6,
        //                   child: Row(
        //                     children: [
        //                       Image.asset('assets/images/green_sign.png'),
        //                       Column(
        //                         children: [
        //                           Text("Butter Special Pav Bhaji"),
        //                           Text("Salad, extra butter, 3 bread"),
        //                           Text("Customize"),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.4,
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           TextButton(onPressed: null, child: Text("-")),
        //                           Text("1"),
        //                           TextButton(onPressed: null, child: Text("+")),
        //                         ],
        //                       ),
        //                       Text("₹180")
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Row(
        //               children: [
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.6,
        //                   child: Row(
        //                     children: [
        //                       Image.asset('assets/images/red_sign.png'),
        //                       Column(
        //                         children: [
        //                           Text("Masala Mast Paneer Bhatoore"),
        //                           Text("Salad,  2 green chutney"),
        //                           Text("Customize"),
        //                         ],
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   width: MediaQuery.of(context).size.width * 0.4,
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           TextButton(onPressed: null, child: Text("-")),
        //                           Text("1"),
        //                           TextButton(onPressed: null, child: Text("+")),
        //                         ],
        //                       ),
        //                       Text("₹120")
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //     // Container(
        //     //   width: MediaQuery.of(context).size.width * 1,
        //     //   height: MediaQuery.of(context).size.height * 0.1,
        //     //   color: Color.fromRGBO(255, 252, 222, 1),
        //     //   child: Row(
        //     //     children: [
        //     //       Icon(Icons.ac_unit),
        //     //       Text("Apply Coupon"),
        //     //     ],
        //     //   ),
        //     // ),
        //     user_number == null
        //         ? Center(
        //             child: Container(
        //               width: MediaQuery.of(context).size.width * 0.7,
        //               color: Color.fromRGBO(247, 193, 43, 1),
        //               child: TextButton(
        //                 onPressed: null,
        //                 child: Text("Login to continue"),
        //               ),
        //             ),
        //           )
        //         : Center(
        //             child: Text('logged in'),
        //           ),
        //   ],
        // ),
        );
  }
}
