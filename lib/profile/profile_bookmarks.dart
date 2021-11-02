import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Bookmarks',style: TextStyle(
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
            Padding(
              padding: const EdgeInsets.all(11),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(11),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                width: double.infinity,
                height: 33,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 11,
                    ),
                    Icon(
                      Icons.search,
                      color: Color.fromRGBO(255, 206, 69, 0.69),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text('Search within bookmarks'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(11),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('Images/bookmark.png',height: 150,),
                        Container(
                          height: 30,
                          width: 166,
                          color: Colors.yellow,
                          child: Center(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.where_to_vote,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Text('Foodistaan Certified'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 22,
                            ),
                            const Text('Pizza Junction',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                            const Text('Fast Food Snacks',style: TextStyle(
                              color: Colors.grey,
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                              ],
                            ),const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.pink,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Cost for two ₹300'),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.two_wheeler,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Delivery'),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.shopping_bag,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Takeaway'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(11),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.4,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('Images/bookmark.png',height: 150,),
                        Container(
                          height: 30,
                          width: 166,
                          color: Colors.yellow,
                          child: Center(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.where_to_vote,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2.5,
                                ),
                                Text('Foodistaan Certified'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 22,
                            ),
                            const Text('Pizza Junction',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                            const Text('Fast Food Snacks',style: TextStyle(
                              color: Colors.grey,
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                                Icon(Icons.star,color: Colors.yellow,),
                              ],
                            ),const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.pink,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Cost for two ₹300'),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.two_wheeler,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Delivery'),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.shopping_bag,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('Takeaway'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
