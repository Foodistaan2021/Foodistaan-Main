import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GLOBAL_UPDATES",style: TextStyle(color: Color(0xFFFBF8BE)),),
        centerTitle: true,
        backgroundColor: Color(0xFF234E70),
      ),
      body: myhomescreen(),
      backgroundColor: Color(0xFFFBF8BE),
    );
  }
}

class myhomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        country(page: 'H', url: 'https://wallpaperaccess.com/full/4455652.jpg'),
        country(page: 'U', url: 'https://i.imgur.com/07qDwFS.jpg'),

      ],
    );
  }
}

class country extends StatelessWidget {
  String page;
  String url;
  country({required this.page, required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, page);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Hero(tag:'logo$page',child: Image.network(url)),
      ),
    );
  }
}
