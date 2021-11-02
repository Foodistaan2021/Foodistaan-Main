import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:page_transition/page_transition.dart';

class EnterCode extends StatefulWidget {
  final String number;
  EnterCode({required this.number});

  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {

  TextEditingController number = TextEditingController();
  final numberKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final fireStore = Firebase.initializeApp();

  bool edit = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    verifyPhone();
    // getData();
  }

  getData() async{
    await fireStore.then((value) async {
      FirebaseFirestore.instance.
      collection("restaurants").doc("kfc").set({
        "number": widget.number,
      });
    });
  }

  String? verificationCode;

  verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.number}",
      verificationCompleted: (PhoneAuthCredential credential) async{
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async{
          if(value.user != null){
            // Navigator.pushReplacement(context, PageTransition(
            //   curve: Curves.easeInOut,
            //   duration: Duration(milliseconds: 500),
            //   type: PageTransitionType.rightToLeft,
            //   child: HomePage(),
            // ));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e){
        print("Error: ${e.message}");
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          verificationCode = verificationID;
          print(verificationCode);
        });
      },
      codeAutoRetrievalTimeout: (String verificationID){
        setState(() {
          verificationCode = verificationID;
          print(verificationCode);
        }); 
      },
      timeout: Duration(seconds: 60),
    );
  }

  onSubmit(String pin) async{
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationCode!,
            smsCode: pin),
      ).then((val) async{
        if(val.user != null){
          fireStore.then((value) async {
            FirebaseFirestore.instance.
            collection("users").doc("+91${widget.number}").set({
              "number": widget.number,
             
            }).then((value) {
              setState(() {
                loading = false;
              });
              Navigator.pushReplacement(context, PageTransition(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: MainScreen(),
              ));
            });
          });
        }
      });
    }  catch (e){
      setState(() {
        loading = false;
      });
      FocusScope.of(context).unfocus();
      snackBar("invalid OTP");
    }
  }

  snackBar(String s){
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(
        SnackBar(duration: Duration(milliseconds: 2000),backgroundColor: Colors.white,
            padding: EdgeInsets.only(left: 25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Text(s,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),),
            ),
            behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff4E24A3),
        child: loading == false ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("OTP Verification",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),),
            Text("Enter OTP sent to",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("+91 ${widget.number}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.8,
                child: Form(
                  key: numberKey,
                  child: TextFormField(

                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    controller: number,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    onChanged: (value) {
                      if(value.length == 6) {
                        onSubmit(number.text);
                        // if(number.text == "123456"){
                        //   Navigator.push(context, PageTransition(
                        //     curve: Curves.easeInOut,
                        //     duration: Duration(milliseconds: 500),
                        //     type: PageTransitionType.rightToLeft,
                        //     child: HomePage(),
                        //   ));
                        // }else{
                        //   snackBar("Code is wrong");
                        // }
                      }
                    },
                    validator: (val){
                      return val!.length != 6 ? "6 Digits" : null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter  Code",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 10,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Don't Receive the OTP?  ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                  Text("RESENT OTP",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                ],
              ),
            ),
          ],
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
