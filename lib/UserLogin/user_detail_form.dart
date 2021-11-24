import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/HomeScreenFile.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail extends StatefulWidget {
  String phone_number;

  UserDetail({required this.phone_number});
  @override
  _UserDetailState createState() => _UserDetailState();
}

addUser(_userData) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(_userData['phoneNumber'])
      .set({
    'name': _userData['name'],
    'email': _userData['email'],
    'phoneNumber': _userData['phoneNumber'],
    'dateAndTime': _userData['dateAndTime'],
    'profilePic': _userData['profilePic'],
  });
  String uId = FirebaseAuth.instance.currentUser!.uid;
  await CartFunctions().createCartFeild(uId, _userData['phoneNumber']);
}

class _UserDetailState extends State<UserDetail> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Map<String, dynamic> _userData = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'dateAndTime': '',
    'profilePic': '',
  };

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0F1B2B),
      ),
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              child:
                  Image.asset('Images/top.jpeg', height: 20, fit: BoxFit.fill)),
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.15,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Image.asset('Images/pic4.png'),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.09,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: nameController,
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: 'Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.09,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: emailController,
                //keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: 'Email-id',
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  _userData['name'] = nameController.text;
                  _userData['email'] = emailController.text;
                  _userData['phoneNumber'] = widget.phone_number;
                  _userData['dateAndTime'] = DateTime.now().toString();
                  addUser(_userData).then((v) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF7C12B),
                  fixedSize: Size(100, 48),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
