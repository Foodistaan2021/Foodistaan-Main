import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodistan/UserLogin/OTPScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();

  getMobileFormWidget(context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset('Images/loginTop.png', fit: BoxFit.fill)),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome To",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF7C12B),
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    letterSpacing: MediaQuery.of(context).size.width * 0.008),
              ),
              Text(
                "FOODISTAAN",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F1B2B),
                    fontSize: MediaQuery.of(context).size.height * 0.06,
                    letterSpacing: MediaQuery.of(context).size.width * 0.01),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 10,
            textAlign: TextAlign.center,
            controller: _phoneNumberController,
            //keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              focusColor: Color(0xFFF7C12B),
              hintText: 'Phone Number',
              prefix: Text(
                '+91',
                textAlign: TextAlign.end,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(
                  color: Color(0xFFF7C12B),
                  width: 3.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          child: ElevatedButton(
            onPressed: () async {
              if (_phoneNumberController.text != "" &&
                  _phoneNumberController.text.length == 10) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OTPScreen(phone: "+91" + _phoneNumberController.text),
                  ),
                );
              }
            },
            child: Text(
              'Send OTP',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFF7C12B)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFF7C12B)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ))),
          ),
        ),
        //   ],
        // ),

        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.26,
            child: Image.asset('Images/bottom.jpeg', fit: BoxFit.fill)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: getMobileFormWidget(context),
        ),
      ),
    );
  }
}
