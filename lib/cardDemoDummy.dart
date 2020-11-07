import 'package:flutter/material.dart';

Widget cardDemoDummy(BuildContext context, {
  @required double right,
  @required double left,
  @required double cardWidth,
  @required double rotation,
  @required double skew,
  
}) {
  Size screenSize = MediaQuery.of(context).size;
  var width = screenSize.width / 1.2 + cardWidth;
  
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    width: width,
    height: screenSize.height / 100 * 65.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
        image: NetworkImage("https://cdn.pixabay.com/photo/2020/09/02/18/03/girl-5539094_960_720.jpg"),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Spacer(), 
          Icon(Icons.more_horiz, color: Colors.white),
        ],),
        Spacer(),
        //name
        RichText(
          text: TextSpan(
            text: "Amy,",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w900, color: Colors.white),
            children: [
              TextSpan(text: "  26", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.white70),),
            ]
          ),
        ),
        //info
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "amywhatson1234",
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Row(
            children: [
              //text
              Text(
                "SAVED THE PUPPY",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic),
              ),

              Spacer(),
              Icon(Icons.error, color: Colors.white,),
            ],
          ),
        ),

      ]
    ),
  );
}