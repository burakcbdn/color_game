import 'dart:async';
import 'dart:math';

import 'package:color_game/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'result_page.dart';

class GamePage extends StatefulWidget {
  final int id;

  const GamePage({Key key, this.id}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool gameStarted = false;

  int count;

  Color colorToFind;

  List<Color> colorPad;

  int score = 0;

  void regenerateGamePad() {
    colorPad.shuffle();
    colorToFind = colorPad[Random().nextInt(colorPad.length)];
    score++;
  }

  Timer timer;
  int timeRemaining = 60;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timeRemaining == 0) {
          timer.cancel();
          Route route = MaterialPageRoute(builder: (context) => ResultPage(score: score,));
          Navigator.pushReplacement(context, route);

        } else {
          timeRemaining--;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    count = widget.id + 3;
    colorPad = colors;
    colorPad.shuffle();

    colorPad = colorPad.sublist(0, pow(count, 2));
    colorToFind = colorPad[Random().nextInt(colorPad.length)];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: gameStarted
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              !gameStarted ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (!gameStarted)
              GestureDetector(
                onTap: () {
                  if (!gameStarted) {
                    setState(() {
                      gameStarted = true;
                    });

                    startTimer();
                  }
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "Start",
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                ),
              ),
            if (gameStarted)
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "$timeRemaining",
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(

                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: colorToFind,

                        ),
                        child: Center(
                          child:  Text(
                            "Find this color",
                            style: TextStyle(color: Colors.white, fontSize: 30,shadows: [Shadow(blurRadius: 1, offset: Offset(1,1))]),

                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(

                      ),
                    ),
                  ],
                ),
              ),
            if (gameStarted)
              Container(
                height:screenSize.height / 2,
                  width: screenSize.height / 2,
                  child: GridView.count(
                crossAxisCount: widget.id + 3,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: colorPad.map((color) {
                  return CupertinoButton(
                    onPressed: () {
                      if (colorToFind == color) {
                        setState(() {
                          regenerateGamePad();
                        });
                      }
                    },
                    minSize: 0,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: color),
                    ),
                  );
                }).toList(),
              )),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}
