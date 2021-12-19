// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ReviewerWidget extends StatefulWidget {
  ReviewerWidget({Key? key}) : super(key: key);

  @override
  _ReviewerWidgetState createState() => _ReviewerWidgetState();
}

class _ReviewerWidgetState extends State<ReviewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.amber.shade400,
              width: 1,
            )),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Image.asset('assets/images/reviewer.png'),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: const [
                    Text(
                      "Tanish Kumar",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("* * *"),
                  ],
                )
              ],
            ),
            Text(
              "Great place must visit. I ordered few Masala Dosa and it came within a minute. They were crispy and delicious, i would definitely recommend it to you",
              style: TextStyle(fontSize: 15),
            ),
            Row(
              children: [
                Image.asset('assets/images/review_image.png'),
              ],
            )
          ],
        ));
  }
}
