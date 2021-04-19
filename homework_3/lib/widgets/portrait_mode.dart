import 'package:flutter/material.dart';

class PortraitScreenBody extends StatefulWidget {
  @override
  _PortraitScreenBodyState createState() => _PortraitScreenBodyState();
}

class _PortraitScreenBodyState extends State<PortraitScreenBody> {
  bool isMercuryPressed = true;
  bool isVenusPressed = false;
  bool isJupiterPressed = false;

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              isMercuryPressed ? Text("Mercury", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)) : SizedBox.shrink(),

              isVenusPressed ? Text("Venus", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)) : SizedBox.shrink(),

              isJupiterPressed ? Text("Jupiter", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)) : SizedBox.shrink(),

              SizedBox(
                height: 30,
              ),
              Image.network( isMercuryPressed ?
              // "https://lh3.googleusercontent.com/proxy/n6_p4T0f4aDUGDuUedwgJA9zuF7cSQ6rQR8Z_HSXjp5fS2KOPyHKb0kFNs5hd5PvlLIAu_TRnnl-KIpx-vlE-aXdsb3sBYkLhwsLQkiOTtewK2QHHFP2-u0EYZzP1IxyfVQ" : ''),
              "https://atlas-content-cdn.pixelsquid.com/assets_v2/239/2399391704680502501/jpeg-600/G03.jpg?modifiedAt=1": ''),
              Image.network( isVenusPressed ?
              "https://atlas-content-cdn.pixelsquid.com/stock-images/venus-rv2Drx4-600.jpg" : ''),
              Image.network( isJupiterPressed ?
              "https://atlas-content-cdn.pixelsquid.com/stock-images/jupiter-VReEG61-600.jpg" : ''),
              SizedBox(
                height: 15,
              ),

              isMercuryPressed ? Text("Mercury is the smallest and closest planet to the Sun in the Solar System. Its orbit around the Sun takes 87.97 Earth days, the shortest of all the planets in the Solar System.Mercury orbits the Sun within Earth's orbit as an inferior planet, and its apparent distance from the Sun as viewed from Earth never exceeds 28°.This proximity to the Sun means the planet can only be seen near the western horizon after sunset. ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),  textAlign: TextAlign.center,) : SizedBox.shrink(),

              isVenusPressed ? Text("Venus is the second planet from the Sun. Venus is a terrestrial planet and is sometimes called Earth's 'sister planet' because of their similar size, mass, proximity to the Sun, and bulk composition. It is radically different from Earth in other respects. It has the densest atmosphere of the four terrestrial planets, consisting of more than 96% carbon dioxide. ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),  textAlign: TextAlign.center,) : SizedBox.shrink(),

              isJupiterPressed ? Text("Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a gas giant with a mass one-thousandth that of the Sun, but two and a half times that of all the other planets in the Solar System combined. Jupiter is the third-brightest natural object in the Earth's night sky after the Moon and Venus. It has been observed since pre-historic times and is named after the Roman god Jupiter.", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),  textAlign: TextAlign.center,) : SizedBox.shrink(),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    child: Text('Mercury'),
                    onPressed: () {
                      setState(() {
                        isMercuryPressed = true;
                        isVenusPressed = false;
                        isJupiterPressed = false;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Venus'),
                    onPressed: () {
                      setState(() {
                        isVenusPressed = true;
                        isMercuryPressed = false;
                        isJupiterPressed = false;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Jupiter'),
                    onPressed: () {
                      setState(() {
                        isJupiterPressed = true;
                        isMercuryPressed = false;
                        isVenusPressed = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
