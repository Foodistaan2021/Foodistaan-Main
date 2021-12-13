import 'package:flutter/material.dart';


class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    return FittedBox(
      alignment: Alignment.bottomLeft,
      fit: BoxFit.contain,
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xFFFAB84C),
            size: h1*0.07,
          ),
          Text("Location",
              style: TextStyle(
                color: Color(0xFF0E1829),
                fontSize: h1 *0.05,
                //fontFamily: 'Segoe UI'
              )),
        ],
      ),
    );
  }
}


class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Points",
                style: TextStyle(
                    color: Color(0xFF0E1829),
                    fontSize: h1 *0.05,
                    //fontFamily: 'Segoe UI'
                )),
            Icon(
              Icons.money,
              color: Color(0xFFFAB84C),
              size: h1 *0.07,
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  Function? searchTask;
  Search({required this.searchTask});
  _SearchState createState() => _SearchState(SearchTask: searchTask!);
}

class _SearchState extends State<Search> {
  @override
  Function SearchTask;
  _SearchState({required this.SearchTask});
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(w1*0.01,h1*0.01,w1*0.01,h1*0.01,),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFCE19E).withOpacity(0.35),
        ),
        height: h1 *0.05,
        width: 12 * w1 / 13,
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            SearchTask();
          },
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.fromLTRB(w1 / 20, h1 / 100, 0, h1 / 100),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Color(0xFF6B6B6B),
                    size: h1 / 40,
                  ),
                  SizedBox(
                    width: w1 / 70,
                  ),
                  Text(
                    "Search Cuisines",
                    style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: h1 / 50,
                        //fontFamily: 'Segoe UI'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
