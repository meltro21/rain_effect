import 'package:delayed_display/delayed_display.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
import 'package:rain_effect/controllers/rain_controller.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  var posFromLeftInt = 10;
  List<double> posFromLeftList = [];
  List<double> slideRandomList = [];
  var uniformDistribution = 0;
  var rng;
  var length = 70;

  //Animaiton variables
  //rain front row
  late List<Animation<double>> slideAnimationListFrontRow = [];
  late List<Animation<double>> splatOpacityListFrontRow = [];
  late List<Animation<double>> dropOpacityListFrontRow = [];
  late List<Animation<double>> hideDropListFrontRow = [];
  late List<Animation<double>> splatScaleListFrontRow = [];

  //rain back row
  late List<Animation<double>> slideAnimationListBackRow = [];
  late List<Animation<double>> splatOpacityListBackRow = [];
  late List<Animation<double>> dropOpacityListBackRow = [];
  late List<Animation<double>> hideDropListBackRow = [];
  late List<Animation<double>> splatScaleListBackRow = [];

  Future<void> myRain(double mediaHeight, double mediaWidth) async {
    var startDrop = 0.0;

    //the loop will create animaiton for each drop
    for (var i = 0; i < length; i++) {
      rng = Random();

      //interval for drop and it's splat
      startDrop += 0.01;
      var endDrop = startDrop + 0.04;
      var startSplat = endDrop;
      var endSplat = endDrop + 0.04;

      //to make drops end at different levels otherwise
      // all drop will be on the same level
      int slideRandomInt = rng.nextInt(30);
      var slideRandomDouble = slideRandomInt.toDouble();

      //to make drop appear at different positoins.
      //pick random number from screen width and assign that position
      posFromLeftInt = rng.nextInt(mediaWidth.toInt()) + 10;
      double posFromLeftDouble = posFromLeftInt.toDouble();
      //print(posFromLeftDouble);
      posFromLeftList.add(posFromLeftDouble);
      slideRandomList.add(slideRandomDouble);

      //front Row
      var slideAnimationFrontRow = Tween<double>(
              begin: 0, end: (mediaHeight - (50 + 35)) + slideRandomDouble)
          .animate(CurvedAnimation(
              parent: controller,
              curve: Interval(
                startDrop,
                endDrop,
              )));
      slideAnimationListFrontRow.add(slideAnimationFrontRow);

      var dropOpacityFrontRow = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(startDrop, startDrop)));
      dropOpacityListFrontRow.add(dropOpacityFrontRow);

      var splatOpacityFrontRow = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(startSplat, endSplat)));
      splatOpacityListFrontRow.add(splatOpacityFrontRow);

      var hideDropFrontRow = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(endDrop, endDrop)));
      hideDropListFrontRow.add(hideDropFrontRow);

      var splatScaleFrontRow = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(startSplat, endSplat)));
      splatScaleListFrontRow.add(splatScaleFrontRow);

      //back row
      var slideAnimateBack = Tween<double>(
              begin: 0, end: (mediaHeight - (50 + 35)) - slideRandomDouble)
          .animate(CurvedAnimation(
              parent: controller,
              curve: Interval(
                startDrop + (slideRandomDouble / 200),
                endDrop + (slideRandomDouble / 200),
              )));
      slideAnimationListBackRow.add(slideAnimateBack);

      var dropOpacityBackRow = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(startDrop + (slideRandomDouble / 200),
                  startDrop + (slideRandomDouble / 200))));
      dropOpacityListBackRow.add(dropOpacityBackRow);

      var splatOpacityBackRow = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval((endDrop + (slideRandomDouble / 200)),
                  (endDrop + (slideRandomDouble / 200) + 0.03))));
      splatOpacityListBackRow.add(splatOpacityBackRow);

      var hideDropBackRow = Tween<double>(begin: 0.5, end: 0).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(endDrop + (slideRandomDouble / 200),
                  endDrop + (slideRandomDouble / 200))));
      hideDropListBackRow.add(hideDropBackRow);

      var splatScaleBackRow = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval((endDrop) + (slideRandomDouble / 200),
                  (endSplat + (slideRandomDouble / 200) + 0.03))));
      splatScaleListBackRow.add(splatScaleBackRow);
    }
    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    //print('duration is ${_controller.duration}');
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff202020), Color(0xff111119)]),
        ),
        height: mediaHeight,
        width: mediaWidth,
        child: FutureBuilder(
            future: myRain(mediaHeight, mediaWidth),
            builder: (context, index) {
              return Stack(children: [
                for (int i = 0; i < length; i++)
                  Positioned(
                    left: posFromLeftList[i],
                    top: slideAnimationListFrontRow[i].value,
                    child: Opacity(
                      opacity: dropOpacityListFrontRow[i].value,
                      child: Opacity(
                        opacity: hideDropListFrontRow[i].value,
                        child: Container(
                          height: 35,
                          width: 2,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0),
                              Color.fromRGBO(255, 255, 255, 0.25)
                            ],
                          )),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                for (int i = 0; i < length; i++)
                  Positioned(
                    left: posFromLeftList[i],
                    top: (mediaHeight - 50) + slideRandomList[i],
                    child: Transform.scale(
                      scale: splatScaleListFrontRow[i].value,
                      child: Opacity(
                        opacity: splatOpacityListFrontRow[i].value,
                        child: Container(
                          decoration: DottedDecoration(
                            color: Colors.white,
                            shape: Shape.box,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 15,
                          width: 7,
                        ),
                      ),
                    ),
                  ),

                //back row
                for (int i = 0; i < length; i++)
                  Positioned(
                    left: posFromLeftList[i] - 20,
                    top: slideAnimationListBackRow[i].value,
                    child: Opacity(
                      opacity: dropOpacityListBackRow[i].value,
                      child: Opacity(
                        opacity: hideDropListBackRow[i].value,
                        child: Container(
                          height: 35,
                          width: 2,
                          decoration: BoxDecoration(
                            //color: Colors.red
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(255, 255, 255, 0),
                                Color.fromRGBO(255, 255, 255, 0.25)
                              ],
                            ),
                          ),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                for (int i = 0; i < length; i++)
                  Positioned(
                    left: posFromLeftList[i] - 20,
                    top: (mediaHeight - 50) - slideRandomList[i] + 20,
                    child: Transform.scale(
                      scale: splatScaleListBackRow[i].value,
                      child: Opacity(
                        opacity: splatOpacityListBackRow[i].value,
                        child: Container(
                          decoration: DottedDecoration(
                            color: Colors.white,
                            shape: Shape.box,
                            borderRadius: BorderRadius.circular(
                                50), //remove this to get plane rectange
                          ),
                          height: 25,
                          width: 7,
                        ),
                      ),
                    ),
                  )
              ]);
            }),
      )),
    );
  }
}
