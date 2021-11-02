import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/profile/settings.dart';
import 'profile_bookmarks.dart';
import 'payment_methods.dart';
import 'profile_address.dart';
import 'foodistaan_pro.dart';
import 'profile_help.dart';
import 'your_orders.dart';
import 'offers.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map items = {
    "name": "",
    "email": "",
    "number": "",
    "pic": "",
  };
  fetchData() async {
    final _firestore = FirebaseFirestore.instance;

    
   String? user_number;
    if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
      user_number = FirebaseAuth.instance.currentUser!.phoneNumber;
    }
    final CollectionReference profileData = _firestore.collection('users');
    try {
      await profileData.doc(user_number).get().then((value) {
        setState(() {
          items["name"] = value.get("name");
          items["email"] = value.get("email");
          items["number"] = value.get("number");
          items["pic"] = value.get("profilePic");
        });
      }).whenComplete(() {
        print(items);
        setState(() {});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // title: const Icon(
          //   Icons.notifications,
          //   color: Colors.black,
          //   size: 27,
          // ),
          leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
          ),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'Images/profilepage.png',
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 115,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              items["name"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 206, 69, 0.69),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(22),
                                bottomLeft: Radius.circular(22),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      items["email"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      items["number"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                child: Image.asset("Images/profilepic.png"),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('Edit'),
                              SizedBox(
                                width: 37.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return const Bookmarks();
                            }),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.bookmark_outline,
                              color: Colors.black,
                              size: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bookmarks',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return const Offers();
                            }),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.black,
                              size: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return const ProfileSettings();
                            }),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                              size: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return const Payments();
                            }),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.payment_outlined,
                              color: Colors.black,
                              size: 27,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Payments',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const Orders();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.history,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Order History',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const Address();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.contacts_outlined,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Saved Address Book',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const Pro();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'About Foodistaan Pro',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const Offers();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.celebration,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Offers & Deals of the Day',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return const Help();
                      }),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.help_outline,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Help',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
