import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/MainScreenFolder/Location/LocationMap.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/functions/places_search_model.dart';
import 'package:foodistan/global/global_variables.dart' as global;
import 'package:foodistan/functions/address_model.dart';

class LocationBottomSheetWidget extends StatefulWidget {
  const LocationBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<LocationBottomSheetWidget> createState() =>
      _LocationBottomSheetWidgetState();
}

class _LocationBottomSheetWidgetState extends State<LocationBottomSheetWidget> {
  AddressModel? userAddress;
  bool hasAddress = false;
  List<PlaceSearch> searchResult = [];
  final searchFeildController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asyncFunctions().then((value) {
      if (value) {
        setState(() {
          hasAddress = true;
        });
      } else {
        setState(() {
          hasAddress = false;
        });
      }
    });
  }

  asyncFunctionSearch(query) async {
    await LocationFunctions().getAutocomplete(query, '').then((value) {
      setState(() {
        searchResult = value;
      });
    });
  }

  clearData() {
    setState(() {
      searchResult = [];
    });
  }

  _asyncFunctions() async {
    var userLocation = await LocationFunctions().getUserLocation();
    if (userLocation != null) {
      var address = await LocationFunctions()
          .getAddress(userLocation.latitude, userLocation.longitude);
      setState(() {
        userAddress = address;
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Select Location',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 11,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: asyncFunctionSearch,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'please Enter';
                        else
                          return null;
                      },
                      controller: searchFeildController,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            if (searchFeildController.text.length > 3)
                              asyncFunctionSearch(searchFeildController.text);
                          },
                        ),
                        // prefixIcon: IconButton(
                        //     onPressed: () async {
                        //       if (searchFeildController.text.length > 3)
                        //         asyncFunctionSearch(searchFeildController.text);
                        //     },
                        //     icon: Icon(
                        //       FontAwesomeIcons.search,
                        //       color: Color(0xfff7c12b),
                        //     ),),
                        // focusColor: Color(0xfff7c12b),
                        // hoverColor: Color(0xfff7c12b),
                        // fillColor: Color(0xfff7c12b),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocation(
                      placeId: null,
                      placeSearched: false,
                    ),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.gps_fixed,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Use Current Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                                hasAddress
                                    ? Text(
                                        userAddress!.subLocality!,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Text(
                                        'No Data',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              searchResult.isNotEmpty
                  ? Center(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: searchResult.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddLocation(
                                          placeId: searchResult[index].placeId,
                                          placeSearched: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    color: Colors.white,
                                    child: Center(
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                        ),
                                        title: Text(
                                          searchResult[index].description,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Colors.white,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Saved Addresses',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SavedAddressWidget(),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavedAddressWidget extends StatefulWidget {
  const SavedAddressWidget({Key? key}) : super(key: key);

  @override
  _SavedAddressWidgetState createState() => _SavedAddressWidgetState();
}

class _SavedAddressWidgetState extends State<SavedAddressWidget> {
  @override
  void initState() {
    super.initState();
  }

  asyncFunction() async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .get()
        .then((value) {
      for (var item in value.docs) {
        print(item.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
