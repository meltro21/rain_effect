import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indexed/indexed.dart';
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final AnimationController _controller1 = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<Offset> _offsetAnimation1 = Tween<Offset>(
    begin: Offset(0.1, 0.0),
    end: const Offset(0.1, 3),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  late var sizeAnimation =
      Tween<double>(begin: 100.0, end: 200.0).animate(_controller);
  late var colorAnimation =
      ColorTween(begin: Colors.blue, end: Colors.yellow).animate(_controller);
  late var opacityAnimation =
      Tween<double>(begin: 1, end: 0.0).animate(_controller);

  // late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
  //   begin: Offset(70.5, 0.0),
  //   end: const Offset(70.5, 9),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.fastOutSlowIn,
  // ));

  late Animation<double> animation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

  RainController rainController = Get.put(RainController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;

    print('duration is ${_controller.duration}');
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Opacity(
              opacity: opacityAnimation.value,
              child: Container(
                margin: EdgeInsets.only(top: sizeAnimation.value),
                height: 20,
                width: 3,
                color: colorAnimation.value,
              ),
            ),
          ]),

          //Stack with colum inside with traisiition
          // Stack(
          //   children: [
          //     SlideTransition(
          //       position: _offsetAnimation1,
          //       child: Container(
          //         height: 60,
          //         width: 30,
          //         //color: Colors.red,
          //         child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                     gradient: LinearGradient(
          //                         begin: Alignment.topCenter,
          //                         end: Alignment.bottomCenter,
          //                         colors: [
          //                       Color.fromRGBO(255, 255, 255, 0),
          //                       Color.fromRGBO(255, 255, 255, 0.5),
          //                     ])),
          //                 height: 20,
          //                 width: 3,
          //               ),
          //               SizeTransition(
          //                 sizeFactor: _controller,
          //                 child: Container(
          //                   color: Colors.pink,
          //                   height: 2,
          //                   width: 3,
          //                 ),
          //               ),
          //             ]),
          //       ),
          //     )
          //   ],
          // )
          //
          //
          // Indexer(
          //   children: [
          //     Indexed(
          //       index: 2,
          //       child: Positioned(
          //         child: Container(
          //           // height: 100,
          //           // width: 20,
          //           //color: Colors.red,
          //           child: SlideTransition(
          //             position: _offsetAnimation1,
          //             child: Column(children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                     gradient: LinearGradient(
          //                         begin: Alignment.topCenter,
          //                         end: Alignment.bottomCenter,
          //                         colors: [
          //                       Color.fromRGBO(255, 255, 255, 0),
          //                       Color.fromRGBO(255, 255, 255, 0.5),
          //                     ])),
          //                 width: 1,
          //                 height: 30,
          //               ),
          //               // Container(
          //               //   height: 10,
          //               //   width: 15,
          //               //   decoration: BoxDecoration(
          //               //       color: Color.fromRGBO(255, 255, 255, 0.5),
          //               //       border: Border(top: BorderSide(width: 1))),
          //               // ),
          //             ]),
          //           ),
          //         ),
          //       ),
          //     ),
          //     // Indexed(
          //     //   index: 1,
          //     //   child: AnimatedContainer(
          //     //       duration: Duration(seconds: 5),
          //     //       width: 35,
          //     //       height: 50,
          //     //       decoration: BoxDecoration(
          //     //         color: Colors.white,
          //     //         border: Border(
          //     //             top: BorderSide(width: 1, style: BorderStyle.solid)),
          //     //       )),
          //     // ),
          //     // Indexed(
          //     //     index: 1,
          //     //     child: SizeTransition(
          //     //       sizeFactor: CurvedAnimation(
          //     //         curve: Curves.fastOutSlowIn,
          //     //         parent: _controller,
          //     //       ),
          //     //       child: Container(
          //     //         height: 10,
          //     //         width: 15,
          //     //         decoration: BoxDecoration(
          //     //             color: Color.fromRGBO(255, 255, 255, 0.5),
          //     //             border: Border(top: BorderSide(width: 1))),
          //     //       ),
          //     //     )),
          //     // Indexed(
          //     //   index: 1,
          //     //   child: Opacity(
          //     //     opacity: 0.5,
          //     //     child: Positioned(
          //     //       child: SlideTransition(
          //     //         position: _offsetAnimation2,
          //     //         child: Container(
          //     //           decoration: BoxDecoration(
          //     //               gradient: LinearGradient(
          //     //                   begin: Alignment.topCenter,
          //     //                   end: Alignment.bottomCenter,
          //     //                   colors: [
          //     //                 Color.fromRGBO(255, 255, 255, 0),
          //     //                 Color.fromRGBO(255, 255, 255, 0.5),
          //     //               ])),
          //     //           width: 1,
          //     //           height: 30,
          //     //         ),
          //     //       ),
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),

          // // Stack(
          // //   children: [
          // //     //Rain Drop
          // //     SlideTransition(
          // //       position: _offsetAnimation,
          // //       child: Container(
          // //         decoration: BoxDecoration(
          // //             gradient: LinearGradient(
          // //                 begin: Alignment.topCenter,
          // //                 end: Alignment.bottomCenter,
          // //                 colors: [
          // //               Color.fromRGBO(255, 255, 255, 0),
          // //               Color.fromRGBO(255, 255, 255, 0.5),
          // //             ])),
          // //         width: 1,
          // //         height: 30,
          // //       ),
          // //     ),
          // //     //back rain drop
          // //     // SlideTransition(
          // //     //   position: _offsetAnimation,
          // //     //   child: Card(
          // //     //     elevation: 10,
          // //     //     child: Container(
          // //     //       decoration: BoxDecoration(
          // //     //           gradient: LinearGradient(
          // //     //               begin: Alignment.topCenter,
          // //     //               end: Alignment.bottomCenter,
          // //     //               colors: [
          // //     //             Color.fromRGBO(255, 255, 255, 0),
          // //     //             Color.fromRGBO(255, 255, 255, 0.5),
          // //     //           ])),
          // //     //       width: 1,
          // //     //       height: 30,
          // //     //     ),
          // //     //   ),
          // //     // ),
          // //   ],
          // // ),
        ),
      ),
    );
  }
}
