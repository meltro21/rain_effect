import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rain_effect/controllers/rain_controller.dart';

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
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1, milliseconds: 500),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(30.5, 0.0),
    end: const Offset(30.5, 40.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  RainController rainController = Get.put(RainController());
  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: mediaHeight,
        width: mediaWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(
                  0xff202020,
                ),
                Color(0xff111119)
              ]),
        ),
        child: Stack(
          children: [
            //Rain Drop
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: 1,
                height: 15,
                color: Colors.white,
              ),
            ),
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                width: 1,
                height: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
