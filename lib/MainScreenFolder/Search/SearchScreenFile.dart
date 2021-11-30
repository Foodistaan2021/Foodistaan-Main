// import 'package:flutter/material.dart';
// import 'ListingsFile.dart';
// import 'FilterFile.dart';
//
//
// class RestaurantSearch extends SearchDelegate<String> {
//   final Restaurants = [
//     "Noah",
//     "Uncle's",
//     "Gupta Burger",
//     "Aggarwal Sweets",
//     "Bunty Treat",
//     "Icy Spicy",
//     "Dip Sip",
//     "Slick Chick",
//     "Arjun Pav Bhaaji",
//     "Giani's"
//   ];
//   final Recents = [
//     "Gupta Burger",
//     "Aggarwal Sweets",
//     "Bunty Treat",
//     "Icy Spicy",
//   ];
//   List FiltersSelected=[0,100.0,0,0];
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       Row(
//         children: [
//           IconButton(icon: Icon(Icons.filter_alt ), onPressed: (){
//              Navigator.push(
//               context,
//                MaterialPageRoute(builder: (context) => Filter(Info:FiltersSelected)),
//              );
//
//           }),
//           IconButton(
//               icon: Icon(Icons.clear),
//               onPressed: () {
//                 query = "";
//               }),
//         ],
//       )
//     ];
//   }
//
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//   }
//
//   Widget buildResults(BuildContext context) {
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     var h1 = MediaQuery.of(context).size.height;
//     var w1 = MediaQuery.of(context).size.width;
//     final SuggestionList = query.isEmpty ? Recents : Restaurants;
//     return ListView.builder(itemBuilder: (context, index) => Padding(
//       padding: EdgeInsets.all(w1/40),
//       child: ListedTile(),
//     ),
//     itemCount: SuggestionList.length,);
//   }
// }
//
