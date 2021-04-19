import 'package:flutter/material.dart';

class LandscapeScreenBody extends StatefulWidget {
  @override
  _LandscapeScreenBodyState createState() => _LandscapeScreenBodyState();
}

class _LandscapeScreenBodyState extends State<LandscapeScreenBody> {
  bool isMercuryPressed = true;
  bool isVenusPressed = false;
  bool isJupiterPressed = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Image.network(
                  isMercuryPressed
                      ? "https://atlas-content-cdn.pixelsquid.com/assets_v2/239/2399391704680502501/jpeg-600/G03.jpg?modifiedAt=1"
                      : '',
                  width: size.width * 0.3,
                ),
                Image.network(
                  isVenusPressed
                      ? ("https://atlas-content-cdn.pixelsquid.com/stock-images/venus-rv2Drx4-600.jpg")
                      : '',
                  width: size.width * 0.3,
                ),
                Image.network(
                  isJupiterPressed
                      ? "https://atlas-content-cdn.pixelsquid.com/stock-images/jupiter-VReEG61-600.jpg"
                      : '',
                  width: size.width * 0.3,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                isMercuryPressed
                    ? Text("Mercury",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                    : SizedBox.shrink(),
                isVenusPressed
                    ? Text("Venus",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                    : SizedBox.shrink(),
                isJupiterPressed
                    ? Text("Jupiter",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))
                    : SizedBox.shrink(),
              ]),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 64.8),
                      height: 64,
                      width: size.width * 0.4,
                      child: ElevatedButton(
                        child: Text('Mercury'),
                        onPressed: () {
                          setState(() {
                            isMercuryPressed = true;
                            isVenusPressed = false;
                            isJupiterPressed = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 64.8),
                      height: 64,
                      width: size.width * 0.4,
                      child: ElevatedButton(
                        child: Text('Venus'),
                        onPressed: () {
                          setState(() {
                            isMercuryPressed = false;
                            isVenusPressed = true;
                            isJupiterPressed = false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 64.8),
                      height: 64,
                      width: size.width * 0.4,
                      child: ElevatedButton(
                        child: Text('Jupiter'),
                        onPressed: () {
                          setState(() {
                            isMercuryPressed = false;
                            isVenusPressed = false;
                            isJupiterPressed = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
