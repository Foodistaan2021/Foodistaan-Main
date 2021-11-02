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
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/images/reviewer.png'),
                Column(
                  children: const [
                    Text("Tanish Kumar"),
                    Text("* * *"),
                  ],
                )
              ],
            ),
            Text(
                "Great place must visit. I ordered few Masala Dosa and it came within a minute. They were crispy and delicious, i would definitely recommend it to you"),
            Row(
              children: [
                Image.asset('assets/images/review_image.png'),
                Image.asset('assets/images/review_image.png'),
                Image.asset('assets/images/review_image.png'),
              ],
            )
          ],
        ));
  }
}
