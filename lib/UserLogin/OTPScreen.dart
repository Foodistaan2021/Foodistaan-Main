import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/UserLogin/user_detail_form.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  OTPScreen({required this.phone});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool showSpinner = false;
  String? verificationCode;
  final _pinOTPController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'Images/otpimage.svg',
          height: MediaQuery.of(context).size.width*0.33,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "OTP Sent to ${widget.phone}",
          style: TextStyle(
            color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width*0.05),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: PinPut(
            fieldsCount: 6,
            withCursor: true,
            textStyle:
                const TextStyle(fontSize: 25,
                    color: Color(0xffF7C12B),),
            eachFieldWidth: MediaQuery.of(context).size.width * 0.1,
            eachFieldHeight: MediaQuery.of(context).size.height * 0.05,
            onSubmit: (pin) async {
              setState(() {
                showSpinner = true;
              });
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
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushNamed(context, 'H');
                      } else {
                        String uId = user!.uid;
                        CartFunctions()
                            .createCartFeild(uId, widget.phone)
                            .then((value) {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pushNamed(context, 'H');
                        });
                      }
                    } else {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserDetail(phone_number: widget.phone)));
                    }
                  });
                }
              } catch (e) {
                setState(() {
                  showSpinner = false;
                });
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.toString()),
                  duration: Duration(seconds: 3,),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('Images/welcometopleft.svg',
                    width: MediaQuery.of(context).size.width*0.44,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset('Images/welcomebottomright.svg',
                        width: MediaQuery.of(context).size.width*0.44,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              getOtpFormWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
