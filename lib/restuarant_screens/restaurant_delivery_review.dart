// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:foodistan/widgets/reviewer_widget.dart';

class RestuarantDeliveryReview extends StatefulWidget {
  static String id = 'restaurant_delivery_review';

  @override
  _RestuarantDeliveryMenuSReview createState() =>
      _RestuarantDeliveryMenuSReview();
}

class _RestuarantDeliveryMenuSReview extends State<RestuarantDeliveryReview> {
  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.9,
          child: DropdownButton(
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top Rated",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: const TextStyle(color: Colors.black),
            items: ['Top Rated', 'Oldest', 'Latest'].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              // selectcountry = val;
              // onSubmit check
            },
          ),
        ),
        Center(
          child: Column(
            children: [
              ReviewerWidget(),
              ReviewerWidget(),
            ],
          ),
        )
      ]),
    );
  }
}
