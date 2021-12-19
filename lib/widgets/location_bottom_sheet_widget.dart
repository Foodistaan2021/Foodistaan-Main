import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/MainScreenFolder/Location/LocationMap.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/functions/places_search_model.dart';
import 'package:foodistan/global/global_variables.dart' as global;
import 'package:foodistan/functions/address_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Select Location',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * 0.08,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: asyncFunctionSearch,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'please Enter';
                    else
                      return null;
                  },
                  textAlign: TextAlign.center,
                  controller: searchFeildController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () async {
                          if (searchFeildController.text.length > 3)
                            asyncFunctionSearch(searchFeildController.text);
                        },
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Color(0xfff7c12b),
                        )),
                    focusColor: Colors.yellow,
                    hintText: 'Search... ',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xFFF7C12B), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          BorderSide(color: Color(0xFFF7C12B), width: 2.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddLocation(
                              placeId: null,
                              placeSearched: false,
                            ))),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: Icon(FontAwesomeIcons.mapPin)),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Use Your Current Location'),
                              hasAddress
                                  ? Text(userAddress!.subLocality!)
                                  : Text('NO Data')
                            ],
                          )),
                      Expanded(
                          flex: 1, child: Icon(FontAwesomeIcons.arrowRight))
                    ],
                  ),
                ),
              ),
            ),
            searchResult.isNotEmpty
                ? Container(
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
                                            placeId:
                                                searchResult[index].placeId,
                                            placeSearched: true,
                                          )));
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.0,
                                          color: Color(0xfff7c12b)))),
                              child: ListTile(
                                leading: Icon(FontAwesomeIcons.mapMarkerAlt),
                                hoverColor: Colors.blueGrey,
                                title: Text(searchResult[index].description,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ),
                          );
                        }),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        backgroundBlendMode: BlendMode.darken),
                  )
                : Center(),
          ],
        ),
      ),
    );
  }
}
