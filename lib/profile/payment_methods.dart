import 'package:flutter/material.dart';

class Payments extends StatelessWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Manage Payment Methods',style: TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 22,
                ),
                Text('Cards',style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Credit, Debit & ATM Cards',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
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
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Sodexo Meal Pass',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 22,
                ),
                Text('UPI',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                ),),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                        Icons.arrow_forward_ios,
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('PayTM UPI',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
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
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Google Pay',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
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
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Other UPI',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 22,
                ),
                Text('Wallets',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                ),),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                        Icons.arrow_forward_ios,
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('PayTM',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
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
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Mobikwik',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
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
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('Freecharge',style: TextStyle(
                      color: Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 22,
                ),
                Text('NetBanking',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                ),),
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                        Icons.keyboard_arrow_down,
                      size: 20,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 66,
                    ),
                    Text('NetBanking',style: TextStyle(
                        color: Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
