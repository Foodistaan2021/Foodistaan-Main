import 'package:flutter/material.dart';

class AcceptedOrder extends StatelessWidget {
  const AcceptedOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Order Status',style: TextStyle(
            color: Colors.black,
          ),),
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('Images/trackorder.png',
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.yellow,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.event_note,
                                color: Colors.yellow,
                                size: 25,
                              ),
                            ),
                          ),
                          const Text('Order',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                          const Text('Confirmed',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.yellow,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.hot_tub,
                                color: Colors.yellow,
                                size: 25,
                              ),
                            ),
                          ),
                          const Text('Food',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                          const Text('Preparing',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.yellow,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.local_mall,
                                color: Colors.yellow,
                                size: 25,
                              ),
                            ),
                          ),
                          const Text('Order',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                          const Text('Placed',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.yellow,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delivery_dining,
                                color: Colors.yellow,
                                size: 25,
                              ),
                            ),
                          ),
                          const Text('Out For',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                          const Text('Delivery',style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.5,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 115,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Know your Delivery Valet',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(
                              height: 5,
                            ),
                            Text('You can Call and Message your Delivery Valet, check his temperature and other details.',style: TextStyle(
                              color: Colors.black,
                            ),),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.delivery_dining,
                          color: Colors.yellow,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                height: 115,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 11,
                          ),
                          Image.asset('Images/valetpic.png',
                            height: 55,
                            width: 55,
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Rahul Sharma',style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('Delivery Executive',style: TextStyle(
                                color: Colors.grey,
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.phone_in_talk,
                          color: Colors.yellow,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 33,
                width: double.infinity,
                color: Colors.green,
                child: Center(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.thermostat,
                            color: Colors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('98.5\'F',style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text('Last Checked: 22 Minutes ago',style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 133,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Want to check your Order details?',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Click below to review your Order details.',style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),),
                            const SizedBox(
                              height: 11,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 33,
                                width: 177,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text('View Order details',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: Icon(
                          Icons.event_note,
                          color: Colors.yellow,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                height: 133,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Do you have any Query?',style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Click below to chat with us.',style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),),
                            const SizedBox(
                              height: 11,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 33,
                                width: 177,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.yellow,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text('Chat with Us',style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 15,
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: Icon(
                          Icons.chat,
                          color: Colors.yellow,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
