import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:swipe/cardDemo.dart';
import 'package:swipe/cardDemoDummy.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> width;
  Animation<double> bottom;
  int flag = 0;
  bool showText = false;
  List data = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];
  List selectedData = [];

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: Duration(milliseconds: 1000), vsync: this
    );

    //rotate....
    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );

    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    //right
    right = Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );

    //bottom
    bottom = Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );

    //width
     width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  dismissImg() {
    setState(() {
      setState(() {
        showText = true;
      });
    });
  }

  addImg() {
    setState(() {
      showText = false;
    });
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  //swipe right
  swipeRight() {
    if (flag == 0) {
      setState(() {
        flag = 1;
      });
    }
    _swipeAnimation();
  }

  //swipe left
  swipeLeft() {
    if (flag == 1) {
      setState(() {
        flag = 0;
      });
    }
    _swipeAnimation();
  }

  Widget bottomActionsButton(BuildContext context) {
  Color color = Colors.blue;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //iconbuttons
        iconButton(context, Icons.refresh, Colors.yellow, () {}),
        iconButton(context, Icons.close, Colors.pink, () {
          swipeRight();
        }),
        iconButton(context, Icons.star_rate, Colors.blue, () {}),
        iconButton(context, Icons.favorite, Colors.green, () {
          swipeLeft();
        }),
        iconButton(context, Icons.flash_on, color, () {}),
      ],
    ),
  );
}

  
  @override
  Widget build(BuildContext context) {
    timeDilation = 0.6;

    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;

    // final width = MediaQuery.of(context).size.width / 100;
    // final height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      backgroundColor: Color(0XFF011524),
      body: Column(
        children: [
          //list of Widget
          actionsButton(context),
          dataLength > 0
          ? Stack(
            alignment: AlignmentDirectional.center,
            children: data.map((item) {
              if (data.indexOf(item) == dataLength - 1) {
                return cardDemo(context, 
                  right: right.value, 
                  left: 0.0, 
                  cardWidth: backCardWidth + 10, 
                  rotation: rotate.value, 
                  skew: rotate.value < -10 ? 0.1 : 0.0, 
                  flag: flag,
                  showText: showText,
                );
              } else {
                backCardPosition = backCardPosition - 10;
                backCardWidth = backCardWidth + 10;

                return cardDemoDummy(context, 
                  right: 0.0, 
                  left: 0.0, 
                  cardWidth: backCardWidth, 
                  rotation: 0.0, 
                  skew: 0.0,
                );
              }
            }).toList(),
          ) : Text("No Event Left",
                  style: new TextStyle(color: Colors.white, fontSize: 50.0)),

          Spacer(),
          //bottom list action buttons
          bottomActionsButton(context),
        ]
      ),
    );
  }
}

Widget actionsButton(BuildContext context) {
  Color color = Colors.blue;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //iconbuttons
        iconButton(context, Icons.whatshot, Colors.pink, () {}),
        iconButton(context, Icons.flight, color, () {}),
        iconButton(context, Icons.person_search, color, () {}),
        iconButton(context, Icons.forum, color, () {}),
        iconButton(context, Icons.person, color, () {}),
      ],
    ),
  );
}



Widget iconButton(BuildContext context, IconData iconData, Color color, Function onTap) {
  return CircleAvatar(
    backgroundColor: Color(0XFF07153A).withOpacity(0.4),
    radius: 30.0,
      child: GestureDetector(
      onTap: onTap,
        child: Icon(
        iconData,
        size: 40.0,
        color: color,
      ),
    ),
  );
}

//card
Widget card(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    width: double.infinity,
    height: MediaQuery.of(context).size.height / 100 * 65.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
        image: NetworkImage("https://cdn.pixabay.com/photo/2020/09/02/18/03/girl-5539094_960_720.jpg"),
        fit: BoxFit.cover,
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