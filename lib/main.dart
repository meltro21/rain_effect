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
  late Animation<double> slide;
  late Animation<double> animateOpacity;
  late Animation<double> animateScale;

  var show = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    slide = Tween<double>(begin: 0, end: 300).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1,
          0.6,
        )));
    animateOpacity = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.6, 1)));
    animateScale = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.6, 1)));
    controller.addListener(() {
      setState(() {
        if (controller.value > 0.6) {
          show = true;
        }
        controller.forward();
      });
    });
    controller.addStatusListener((status) {
      print('value of controller is ${controller.value}');
      if (status == AnimationStatus.completed) {
        controller.repeat();
        setState(() {
          show = false;
        });
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
          show == false
              ? Positioned(
                  top: slide.value,
                  child: Container(
                    height: 40,
                    width: 2.5,
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
                )
              : SizedBox(),
          show == true
              ? Positioned(
                  top: 330,
                  child: Transform.scale(
                    scale: animateScale.value,
                    child: Opacity(
                      opacity: animateOpacity.value,
                      child: Container(
                        // decoration: BoxDecoration(
                        //     border: Border(top: BorderSide(width: 2)),
                        //     color: Color.fromRGBO(255, 255, 255, 0.5),
                        //     borderRadius: BorderRadius.circular(50)),
                        decoration: DottedDecoration(
                          shape: Shape.box,
                          borderRadius: BorderRadius.circular(
                              50), //remove this to get plane rectange
                        ),
                        height: 10,
                        width: 7,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ]),
      )),
    );
  }
}
