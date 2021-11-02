import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/Data/data.dart';
import 'package:foodistan/MainScreenFolder/ListingsFile.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';

import 'LocationPointsSearch.dart';

class MainScreenAppBar extends StatelessWidget {
  // List<dynamic> find(String s){
  //   List n = [];
  //   for(int i  = 0; i < Data.restaurants.length; i++){
  //     if(Data.restaurants[i].startsWith(s)){
  //       n.add(Data.restaurants[i]);
  //       if(once == false){
  //         inx = i;
  //         once = true;
  //       }
  //     }
  //   }
  //   return n;
  // }

  int inx = 0;
  bool once = false;

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        height: h1 * 0.03,
        color: Color(0xFFFAB84C),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Container(
          height: h1 / 20,
          width: w1,
          child: Row(
            children: [
              Expanded(flex: 3, child: Location()),
              Expanded(flex: 1, child: Points()),
            ],
          ),
        ),
      ),
      Search(
        searchTask: () {
          showSearch(
              context: context, delegate: DataSearch(file: Data.restaurants));
        },
      ),
    ]);
  }
}

class DataSearch extends SearchDelegate<String> {
  var file;

  DataSearch({this.file});

  // String n;
  String n = "Loading...";
  bool yes = false;
  int inx = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for app bar
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () {
          query = "";
          n = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (yes == false) {
      query = n;
    }
    for (int i = 0; i < Data.restaurants.length; i++) {
      if (query == file[i]) {
        inx = i;
        break;
      }
    }
    return MainScreen();
  }

  List<dynamic> find(String s) {
    s.length >= 1
        ? s = s.substring(0, 1).toUpperCase() + s.substring(1, s.length)
        : s = s.substring(0, 1).toUpperCase();
    List n = [];
    for (int i = 0; i < Data.restaurants.length; i++) {
      if (file[i].startsWith(s)) {
        n.add(file[i]);
      }
    }
    return n;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? Data.recent
        : find(query).toList().isEmpty
            ? Data.recent
            : find(query).toList();

    return query.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 105,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 32,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xff656464),
                                    )),
                                alignment: Alignment.center,
                                child: Text(
                                  "4.0+ Rating",
                                  style: TextStyle(
                                    color: Color(0xff656464),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  height: 32,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff656464),
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Foodistaan Certified",
                                    style: TextStyle(
                                      color: Color(0xff656464),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 32,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xff656464),
                                    )),
                                alignment: Alignment.center,
                                child: Text(
                                  "Pure Veg",
                                  style: TextStyle(
                                    color: Color(0xff656464),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Container(
                                  height: 32,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xff656464),
                                      )),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Delivery",
                                    style: TextStyle(
                                      color: Color(0xff656464),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Listings(),
                        Listings(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              suggestionList.length.toString() == null ?
                              "0" : suggestionList.length.toString() + "  Search Result Found",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: Text("Showing Result for: $query",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Listings(),
                        Listings(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
    //   ListView.builder(
    //   shrinkWrap: true,
    //   itemBuilder: (context, index) {
    //     yes = false;
    //     n = suggestionList[0];
    //     return ListTile(
    //       onTap: () {
    //         yes = true;
    //         query = suggestionList[index];
    //         showResults(context);
    //       },
    //       leading: Icon(
    //         Icons.fastfood_outlined,
    //         size: 20,
    //       ),
    //       title: RichText(
    //         text: TextSpan(
    //             text: suggestionList[index].substring(0, query.length),
    //             style: TextStyle(
    //               color: Colors.black,
    //               fontWeight: FontWeight.bold,
    //             ),
    //             children: [
    //               TextSpan(
    //                   text: suggestionList[index].substring(query.length),
    //                   style: TextStyle(color: Colors.grey))
    //             ]),
    //       ),
    //     );
    //   },
    //   itemCount: suggestionList.length,
    // );
  }
}
