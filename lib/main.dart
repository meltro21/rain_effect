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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late List<Animation<double>> slideAnimateList = [];
  late List<Animation<double>> slideAnimateListBack = [];

  late List<Animation<double>> animateDropOpacityList = [];
  late List<Animation<double>> animateDropOpacityListBack = [];

  late List<Animation<double>> hideDropList = [];
  late List<Animation<double>> hideDropListBack = [];

  late List<Animation<double>> animateScaleList = [];
  late List<Animation<double>> animateScaleListBack = [];

  var count = 10;
  List<double> pos1 = [];
  List<double> slideRandomList = [];
  var uniformDistribution = 0;
  var rng;
  var length = 70;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    var startDrop = 0.0;

    for (var i = 0; i < length; i++) {
      rng = Random();

      // if (i % 10 == 0) {
      //   uniformDistribution += 2;
      // }
      //var num = rng.nextInt(7) + uniformDistribution;
      print(startDrop);
      startDrop += 0.01;
      var endDrop = startDrop + 0.05;
      var startSplat = endDrop;
      var endSplat = endDrop + 0.03;

      int slideRandom = rng.nextInt(30);
      var a = slideRandom.toDouble();
      count = rng.nextInt(300) + 10;
      double myNum = count.toDouble();
      //print(myNum);
      pos1.add(myNum);
      slideRandomList.add(a);

      var slideAnimate =
          Tween<double>(begin: 0, end: 290 + a).animate(CurvedAnimation(
              parent: controller,
              curve: Interval(
                startDrop,
                endDrop,
              )));
      slideAnimateList.add(slideAnimate);

      var slideAnimateBack =
          Tween<double>(begin: 0, end: 290 - a).animate(CurvedAnimation(
              parent: controller,
              curve: Interval(
                startDrop + (a / 200),
                endDrop + (a / 200),
              )));
      slideAnimateListBack.add(slideAnimateBack);

      //for front drop
      var animateDropOpacity = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(startSplat, endSplat)));
      animateDropOpacityList.add(animateDropOpacity);
      //for back drop
      var animateDropOpacityBack = Tween<double>(begin: 1, end: 0).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(
                  (endDrop + (a / 200)), (endDrop + (a / 200) + 0.03))));
      animateDropOpacityListBack.add(animateDropOpacityBack);

      //for front
      var hideDrop = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
          parent: controller, curve: Interval(endDrop, endDrop)));
      hideDropList.add(hideDrop);
      //for back
      var hideDropBack = Tween<double>(begin: 0.5, end: 0).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(endDrop + (a / 200), endDrop + (a / 200))));
      hideDropListBack.add(hideDropBack);

      //for front
      var animateScale = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller, curve: Interval(startSplat, endSplat)));
      animateScaleList.add(animateScale);
      //for back
      var animateScaleBack = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
              parent: controller,
              curve: Interval(
                  (endDrop) + (a / 200), (endSplat + (a / 200) + 0.03))));
      animateScaleListBack.add(animateScaleBack);
    }
    controller.addListener(() {
      setState(() {
        // if (controller.value > 0.6) {
        // }
        // controller.forward();
      });
    });
    controller.addStatusListener((status) {
      print('value of controller is ${controller.value}');
      if (status == AnimationStatus.completed) {
        //Future.delayed(Duration(microseconds: 200));
        controller.repeat();
        // setState(() {
        //   show = false;
        // });
      }
    });
    controller.forward();
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
        child: Stack(children: [
          // front row
          for (int i = 0; i < length; i++)
            Positioned(
              left: pos1[i],
              top: slideAnimateList[i].value,
              child: Opacity(
                opacity: hideDropList[i].value,
                child: Container(
                  height: 35,
                  width: 2,
                  decoration: BoxDecoration(
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
          for (int i = 0; i < length; i++)
            Positioned(
              left: pos1[i],
              top: 330 + slideRandomList[i],
              child: Transform.scale(
                scale: animateScaleList[i].value,
                child: Opacity(
                  opacity: animateDropOpacityList[i].value,
                  child: Container(
                    decoration: DottedDecoration(
                      shape: Shape.box,
                      borderRadius: BorderRadius.circular(
                          50), //remove this to get plane rectange
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
              left: pos1[i] - 20,
              top: slideAnimateListBack[i].value,
              child: Opacity(
                opacity: hideDropListBack[i].value,
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
          for (int i = 0; i < length; i++)
            Positioned(
              left: pos1[i] - 20,
              top: 290 - slideRandomList[i] + 35,
              child: Transform.scale(
                scale: animateScaleListBack[i].value,
                child: Opacity(
                  opacity: animateDropOpacityListBack[i].value,
                  child: Container(
                    decoration: DottedDecoration(
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
        ]),
      )),
    );
  }
}
