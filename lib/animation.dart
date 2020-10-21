import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  AnimationController animcontroller;
  Animation<double> animation;
  bool isplaying = true;
  void animate() {
    if (isplaying)
      animcontroller.stop();
    else
      animcontroller.forward();
    setState(() {
      isplaying = !isplaying;
    });
  }

  @override
  void initState() {
    super.initState();
    animcontroller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    )..repeat();

    animation =
        Tween<double>(begin: 0, end: 20 * math.pi).animate(animcontroller)
          ..addListener(() {
            setState(() {});
          });
    animcontroller.forward();
    super.initState();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        animcontroller.reverse();
      else if (status == AnimationStatus.dismissed) animcontroller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Column(
        children: [
          Container(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Transform.rotate(
                angle: animation.value,
                child: Image.asset('lib/images/cieling fan.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 0),
            child: LiteRollingSwitch(
                value: true,
                textOn: "On",
                textOff: "Off",
                colorOn: Colors.greenAccent,
                colorOff: Colors.redAccent,
                iconOn: Icons.done,
                iconOff: Icons.flag,
                textSize: 20,
                onChanged: (bool position) {},
                onTap: animate),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(oldWidget) {
    animcontroller.reset();
    animcontroller.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
