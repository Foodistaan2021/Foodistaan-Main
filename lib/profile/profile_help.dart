import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Help Desk',style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Today, 1:30 pm',style: TextStyle(
              color: Colors.grey,
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                width: 11,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Image(image: AssetImage('Images/helpbot.png'),),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                  right: 20,
                  bottom: 5,
                ),
                child: Center(
                  child: Image.asset('Images/helptext.png',
                    width: double.infinity,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 90,
                      ),
                      SizedBox(
                        width: 225,
                        child: Text('Welcome to Foodistaan Chat Support Help Desk. Let us know how can we help you with your query!',style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.5
                        ),textAlign: TextAlign.left,),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
