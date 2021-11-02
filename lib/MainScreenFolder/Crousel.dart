import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OfferSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return CarouselSlider(
      items: [
        Offers(offerImagePath: 'Images/banner.png'),
        Offers(offerImagePath: 'Images/banner.png'),
        Offers(offerImagePath: 'Images/banner.png'),
        Offers(offerImagePath: 'Images/banner.png'),
      ],
      //carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        height: h1 * 1 / 4,
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10.0),
        image: DecorationImage(
          image: AssetImage(offerImagePath),
          //fit: BoxFit.cover,
        ),
      ),
    );
  }
}
