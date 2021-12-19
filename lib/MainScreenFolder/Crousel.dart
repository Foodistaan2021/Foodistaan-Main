import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OfferSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    return CarouselSlider(
      items: [
        Offers(offerImagePath: 'Images/banner.png'),
        Offers(offerImagePath: 'Images/banner.png'),
        Offers(offerImagePath: 'Images/banner.png'),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        height: h1 * 1 / 5,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 777),
      ),
    );
  }
}

class Offers extends StatelessWidget {
  String offerImagePath = "";
  Offers({required this.offerImagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(11),
        image: DecorationImage(
          image: AssetImage(offerImagePath),
          //fit: BoxFit.cover,
        ),
      ),
    );
  }
}
