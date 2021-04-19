import 'package:flutter/material.dart';
import 'package:solar_system/widgets/landscape_mode.dart';
import 'package:solar_system/widgets/portrait_mode.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMercuryPressed = true;
  bool isVenusPressed = false;
  bool isJupiterPressed = false;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Solar System"),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (Orientation.portrait == orientation) {
              return PortraitScreenBody();
            } else if (Orientation.landscape == orientation) {
              return LandscapeScreenBody();
            } else {
              return PortraitScreenBody();
            }
          },
        ));
  }
}
