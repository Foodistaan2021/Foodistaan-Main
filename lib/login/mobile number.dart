import 'package:flutter/material.dart';
import 'package:foodistan/login/enter%20code.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController number = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool onPress = false;

  snackBar(String s){
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(
        SnackBar(duration: Duration(milliseconds: 2000),backgroundColor: Colors.white,
            padding: EdgeInsets.only(left: 25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              alignment: Alignment.centerLeft,
              child: Text(s,
                style: TextStyle(
                    color: Colors.black, fontSize: 16,
                    fontWeight: FontWeight.w600),),
            ),
            behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff4E24A3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Enter mobile number to continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.help,color: Colors.yellow,size: 18,),
                      Text(" Help",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  controller: number,
                  autofocus: false,
                  textAlign: TextAlign.left,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                  hintText: 'Mobile Number',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    prefixIcon: Container(
                      height: 50,
                      width: 80,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("+91",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    onPress = true;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {
                        onPress = false;
                        if(number.text.length == 10){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return EnterCode(number: number.text,);
                          },));
                          // Navigator.push(context, PageTransition(
                          //   curve: Curves.easeInOut,
                          //   duration: Duration(milliseconds: 500),
                          //   type: PageTransitionType.rightToLeft,
                          //   child: EnterCode(),
                          // ));
                        }else{
                          snackBar("Number should be 10 digit");
                        }
                      });
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  width: onPress == false ?
                  MediaQuery.of(context).size.width*0.75 :
                  MediaQuery.of(context).size.width*0.75 - 25,
                  height: onPress == false ? 50 : 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.5),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text("Get OTP",
                    style: TextStyle(
                        color: Color(0xff4E24A3),
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
