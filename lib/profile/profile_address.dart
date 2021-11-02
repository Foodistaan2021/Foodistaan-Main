import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  const Address({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('My Addresses',style: TextStyle(
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.add,
                  size: 17.5,
                  color: Color.fromRGBO(255, 206, 69, 1),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Add Address',style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                        Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        Text('15m'),
                      ],
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Home',style: TextStyle(
                          color: Colors.black,
                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Sector 1, House No.2, Rohini, Delhi',style: TextStyle(
                            color: Colors.grey,
                        ),),
                        SizedBox(
                          height: 11,
                        ),
                        Text('Add delivery instruction',style: TextStyle(
                            color: Colors.red,
                        ),),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                        Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                        ),
                        Text('15m'),
                      ],
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Home',style: TextStyle(
                          color: Colors.black,
                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Sector 1, House No.2, Rohini, Delhi',style: TextStyle(
                          color: Colors.grey,
                        ),),
                        SizedBox(
                          height: 11,
                        ),
                        Text('Add delivery instruction',style: TextStyle(
                          color: Colors.red,
                        ),),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
