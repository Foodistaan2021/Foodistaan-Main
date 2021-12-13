import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Location extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    return FittedBox(
      alignment: Alignment.bottomLeft,
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xFFFAB84C),
            size: h1*0.055,
          ),
          SizedBox(
            width: 11,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Home',style: TextStyle(
                color: Colors.black,
                fontSize: h1*0.033,
              ),),
              Text('Rohini, Sec 13',style: TextStyle(
                color: Colors.grey,
                fontSize: h1*0.03,
              ),),
            ],
          ),
          // Text("Location",
          //     style: TextStyle(
          //       color: Color(0xFF0E1829),
          //       fontSize: h1 *0.03,
          //     ),),
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
    // var w1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('0',style: TextStyle(
                  color: Color(0xFFFAB84C),
                  fontSize: h1*0.033,
                ),),
                Text('Points',style: TextStyle(
                  color: Colors.black,
                  fontSize: h1*0.033,
                ),),
              ],
            ),
            // Text("Points",
            //     style: TextStyle(
            //         color: Color(0xFF0E1829),
            //         fontSize: h1 *0.03,
            //         //fontFamily: 'Segoe UI'
            //     ),),
            SizedBox(
              width: 11,
            ),
            SvgPicture.asset('Images/fs_points.svg',
              height: h1*0.055,
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
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(11),),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 2,
            ),
          ],
        ),
        height: h1 *0.05,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.contain,
          child: GestureDetector(
            // onTap: () {
            //   SearchTask();
            // },
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0xFFFAB84C),
                    size: h1 / 33,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Search Cuisines",
                    style: TextStyle(
                        color: Colors.grey,
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
