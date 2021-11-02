import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/HomeScreenFile.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail extends StatefulWidget {
  String phone_number;

  UserDetail({required this.phone_number});
  @override
  _UserDetailState createState() => _UserDetailState();
}

addUser(_userData) {
  try {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userData['phoneNumber'])
        .set({
      'name': _userData['name'],
      'email': _userData['email'],
      'phoneNumber': _userData['phoneNumber'],
      'dateAndTime' : _userData['dateAndTime'],
      'profilePic' : _userData['profilePic']
    });
  } on Exception catch (e) {
    print(e.toString());
    return false;
  }

  return true;
}

class _UserDetailState extends State<UserDetail> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Map<String, dynamic> _userData = {
    'name': '',
     'email': '',
      'phoneNumber': '',
      'dateAndTime' : '' ,
      'profilePic':''
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              height: 300,
              child:
                  Image.asset('Images/top.jpeg', height: 20, fit: BoxFit.fill)),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Image.asset('Images/pic4.png'),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 200,
            height: 100,
            child: TextField(
              controller: nameController,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                hintText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            child: TextField(
              controller: emailController,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                focusColor: Colors.yellow,
                hintText: 'Email-id',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
              ),
            ),
          ),
          Container(
            width: 319,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                _userData['name'] = nameController.text;
                _userData['email'] = emailController.text;
                _userData['phoneNumber'] = widget.phone_number;
                _userData['dateAndTime'] = DateTime.now().toString();
                await addUser(_userData);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
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
        ],
      ),
    );
  }
}
