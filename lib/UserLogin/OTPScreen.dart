import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/UserLogin/user_detail_form.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  OTPScreen({required this.phone});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? verificationCode;
  final _pinOTPController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          User? user;
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              user = value.user;
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             UserDetail(phone_number: widget.phone)));
            }
          });
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.phone)
                .get()
                .then((value) {
              if (value.exists) {
                if (value.data()!.containsKey('cart-id')) {
                  Navigator.pushNamed(context, 'H');
                } else {
                  String uId = user!.uid;
                  CartFunctions()
                      .createCartFeild(uId, widget.phone)
                      .then((value) {
                    Navigator.pushNamed(context, 'H');
                  });
                }
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserDetail(phone_number: widget.phone)));
              }
            });
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 2),
          ));
        },
        codeSent: (String vId, int? resendToken) {
          setState(() {
            verificationCode = vId;
          });
        },
        codeAutoRetrievalTimeout: (String vId) {
          setState(() {
            verificationCode = vId;
          });
        },
        timeout: Duration(seconds: 60));
  }

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Color(0xffFFEEC0),
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: Color(0xffF7C12B),
    ),
  );

  getOtpFormWidget(context) {
    return ListView(
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.32,
            child: Image.asset('Images/OTPTop.png', fit: BoxFit.fill)),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.05,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Sent OTP to ${widget.phone}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 15, 30, 0),
          child: PinPut(
            fieldsCount: 6,
            withCursor: true,
            textStyle:
                const TextStyle(fontSize: 25.0, color: Color(0xffF7C12B)),
            eachFieldWidth: MediaQuery.of(context).size.width * 0.1,
            eachFieldHeight: MediaQuery.of(context).size.height * 0.05,
            onSubmit: (pin) async {
              try {
                User? user;
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationCode!, smsCode: pin))
                    .then((value) {
                  if (value.user != null) {
                    user = value.user;
                  }
                });
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.phone)
                      .get()
                      .then((value) {
                    if (value.exists) {
                      if (value.data()!.containsKey('cart-id')) {
                        Navigator.pushNamed(context, 'H');
                      } else {
                        String uId = user!.uid;
                        CartFunctions()
                            .createCartFeild(uId, widget.phone)
                            .then((value) {
                          Navigator.pushNamed(context, 'H');
                        });
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetail(phone_number: widget.phone)));
                    }
                  });
                }
              } catch (e) {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            focusNode: _pinPutFocusNode,
            controller: _pinOTPController,
            submittedFieldDecoration: pinOTPCodeDecoration,
            selectedFieldDecoration: pinOTPCodeDecoration,
            followingFieldDecoration: pinOTPCodeDecoration,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.37,
            child: Image.asset('Images/OTPBottom.png', fit: BoxFit.fill)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        centerTitle: true,
        backgroundColor: Color(0xff0F1B2B),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        child: getOtpFormWidget(context),
      ),
    );
  }
}
