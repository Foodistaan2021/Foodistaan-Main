import 'dart:ui';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'user_detail_form.dart';
import 'package:pinput/pin_put/pin_put.dart';

class GetOTP extends StatefulWidget {
String phone;
  GetOTP({required this.phone});
  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  String verificationCode = "";
  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        final _userDetail = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.phone)
            .get();

        _userDetail.exists
            ? Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()))
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserDetail(phone_number: widget.phone)));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      // _scaffoldKey.currentState.ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }


  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
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
                style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
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
            onSubmit: (String pin) async {
              try {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationCode, smsCode: pin);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              } catch (e) {}
            },
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutDecoration,
            selectedFieldDecoration: pinPutDecoration,
            followingFieldDecoration: pinPutDecoration,
            pinAnimationType: PinAnimationType.fade,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
          ),child: Text("Resending OTP in $_start seconds",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),),),
        ),
        Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.37,
            child: Image.asset('Images/OTPBottom.png', fit: BoxFit.fill)),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("OTP Verification"),
        centerTitle: true,
        backgroundColor: Color(0xff0F1B2B),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : getOtpFormWidget(context),
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      verificationCompleted: (PhoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthCredential)
            .then((value) async {
          if (value.user != null) {
            signInWithPhoneAuthCredential(PhoneAuthCredential);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 120),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone();
    startTimer();
  }
}
