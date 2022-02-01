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
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.058,
          width: MediaQuery.of(context).size.width * 0.36,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.025,
              top: MediaQuery.of(context).size.height * 0.01),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(width: 1.5, color: Color.fromRGBO(247, 193, 43, 1)),
            color: Colors.transparent,
          ),
          child: DropdownButton(
            underline: SizedBox(),
            hint: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Top Rated",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            isExpanded: true,
            iconSize: 40,
            iconEnabledColor: Color.fromRGBO(248, 200, 69, 1),
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
        ReviewerWidget(),
      ]),
    );
  }
}
