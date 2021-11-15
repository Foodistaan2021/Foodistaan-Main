import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/HomeScreenFile.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'user_detail_form.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
//import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:foodistan/UserLogin/OTPScreen.dart';




class LoginScreen extends StatelessWidget {
  final phoneController = TextEditingController();
  bool showLoading = false;


  getMobileFormWidget(context) {
    return ListView(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.3,
            child:
            Image.asset('Images/loginTop.png',fit: BoxFit.fill)),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.18,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.01,MediaQuery.of(context).size.width * 0.02,MediaQuery.of(context).size.height * 0.01,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to",style: TextStyle(color: Color(0xFFF7C12B),fontSize: MediaQuery.of(context).size.height * 0.05),),
                Text("FOODISTAAN",style: TextStyle(color: Color(0xFF0F1B2B),fontSize: MediaQuery.of(context).size.height * 0.08,letterSpacing: MediaQuery.of(context).size.width * 0.01),),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.09,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: phoneController,
              //keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                focusColor: Color(0xFFF7C12B),
                hintText: 'Phone Number',
                prefix: Text("+91"),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
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
            height: MediaQuery.of(context).size.height * 0.07,
            child: ElevatedButton(
              onPressed: () async {
                if(phoneController.text!="" && phoneController.text.length==10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        GetOTP(phone: "+91" + phoneController.text,),
                    ),);
                }

              },
              child: Text(
                'Send OTP',
                style: TextStyle(
                  fontSize:17,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF7C12B),
                fixedSize: Size(100, 48),
              ),
            ),
          ),
        ),
        //   ],
        // ),

        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.asset('Images/bottom.jpeg',fit: BoxFit.fill)),
      ],
    );
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        child: showLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
        :getMobileFormWidget(context),

      ),
    );
  }
}

