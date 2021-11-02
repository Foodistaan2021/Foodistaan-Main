import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  List Info;
  Filter({required this.Info});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        backgroundColor: Color(0xffF6D066),
      ),
      body: FilterTypes(OptionsSelected: Info),
    );
  }
}

class FilterTypes extends StatelessWidget {
  List OptionsSelected;
  FilterTypes({required this.OptionsSelected});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Sorting(OS:OptionsSelected),
        PriceRange(OS:OptionsSelected),
        Rating(OS: OptionsSelected),
        VegNonveg(OS: OptionsSelected,)
      ],
    );
  }
}

class VegNonveg extends StatefulWidget {
  List OS;
  VegNonveg({required this.OS});
  @override
  _VegNonvegState createState() => _VegNonvegState(OptionsSelected:OS);
}

class _VegNonvegState extends State<VegNonveg> {
  List OptionsSelected;
  _VegNonvegState({required this.OptionsSelected});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              OptionsSelected[3]=1;
            });
          },
          child: Container(
            child: Text("Veg",style: TextStyle(
              color: OptionsSelected[3]==1?Colors.white:Colors.black,
            ),),
            color: OptionsSelected[3]==1?Color(0xffF6D066):Color(0xffF2F2F2),
          ),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              OptionsSelected[3]=2;
            });
          },
          child: Container(
            child: Text("Non-Veg",style: TextStyle(
              color: OptionsSelected[3]==2?Colors.white:Colors.black,
            ),),
            color: OptionsSelected[3]==2?Color(0xffF6D066):Color(0xffF2F2F2),
          ),
        )
      ],
    );
  }
}


class Rating extends StatefulWidget {
  List OS;
  Rating({required this.OS});
  @override
  _RatingState createState() => _RatingState(OptionsSelected:OS);
}

class _RatingState extends State<Rating> {
  List OptionsSelected;
  _RatingState({required this.OptionsSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text("Rating"),
          Row(
            children: [
              IconButton(icon: Icon(Icons.star,color: OptionsSelected[2]<1?Colors.grey:Color(0xffF6D066)), onPressed: (){
                setState(() {
                  OptionsSelected[2]=1;
                });

              }),
              IconButton(icon: Icon(Icons.star,color: OptionsSelected[2]<2?Colors.grey:Color(0xffF6D066)), onPressed: (){
                setState(() {
                  OptionsSelected[2]=2;
                });
              }),
              IconButton(icon: Icon(Icons.star,color: OptionsSelected[2]<3?Colors.grey:Color(0xffF6D066)), onPressed: (){
                setState(() {
                  OptionsSelected[2]=3;
                });
              }),
              IconButton(icon: Icon(Icons.star,color: OptionsSelected[2]<4?Colors.grey:Color(0xffF6D066)), onPressed: (){
                setState(() {
                  OptionsSelected[2]=4;
                });
              }),
              IconButton(icon: Icon(Icons.star,color: OptionsSelected[2]<5?Colors.grey:Color(0xffF6D066)), onPressed: (){
                setState(() {
                  OptionsSelected[2]=5;
                });
              }),

            ],
          )],
      ),
    );
  }
}


class PriceRange extends StatefulWidget {
  List OS;
  PriceRange({required this.OS});
  @override
  _PriceRangeState createState() => _PriceRangeState(OptionsSelected:OS);
}

class _PriceRangeState extends State<PriceRange> {
  List OptionsSelected;
  _PriceRangeState({required this.OptionsSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Price Range for 2: " + OptionsSelected[1].toString()),
          Slider(
            value: OptionsSelected[1].toDouble(),
            min: 100,
            max: 10000,
            activeColor: Color(0xffF6D066),
            inactiveColor: Color(0xffFCE19E),
            //divisions: 5,
            label: OptionsSelected[1].toString(),
            onChanged: (double value) {
              setState(() {
                OptionsSelected[1] = value.round();
              });
            },
          ),
        ],
      ),
    );
  }
}





class Sorting extends StatefulWidget {
  @override
  List OS;
  Sorting({required this.OS});
  _SortingState createState() => _SortingState(OptionsSelected:OS);
}

class _SortingState extends State<Sorting> {
  List OptionsSelected;
  _SortingState({required this.OptionsSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:[
          Text("Sort by:"),
          GestureDetector(
              onTap: () {
                setState(() {
                  OptionsSelected[0] = 1;
                });
              },
              child: SortOrder(
                  os: OptionsSelected, n: 1, t: "Preparation time max to min")),
          GestureDetector(
              onTap: () {
                setState(() {
                  OptionsSelected[0] = 2;
                });
              },
              child: SortOrder(
                  os: OptionsSelected, n: 2, t: "Preparation time min to max")),
          GestureDetector(
              onTap: () {
                setState(() {
                  OptionsSelected[0] = 3;
                });
              },
              child: SortOrder(
                  os: OptionsSelected, n: 3, t: "Cost High to Low")),
          GestureDetector(
              onTap: () {
                setState(() {
                  OptionsSelected[0] = 4;
                });
              },
              child: SortOrder(
                  os: OptionsSelected, n: 4, t: "Cost Low to High")),
        ]
      ),
    );
  }
}

class SortOrder extends StatelessWidget {
  List os;
  int n;
  String t;
  SortOrder({required this.os,required this.n,required this.t});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        t,
        style: TextStyle(
            fontWeight: os[0] == n ? FontWeight.bold : FontWeight.normal),
      ),
      title: Icon(
        Icons.check,
        color: os[0] == n ? Colors.black : Colors.white,
      ),
    );
  }
}

