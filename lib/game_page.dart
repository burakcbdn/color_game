import 'dart:math';

import 'package:color_game/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

  void regenerateGamePad() {
    setState(() {
      colorToFind = colors[Random().nextInt(colors.length)];

      colorPad.shuffle();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    count = widget.id + 3;
    colorPad = colors;
    colorPad.shuffle();

    colorPad = colorPad.sublist(0,pow(count, 2));
    colorToFind = colorPad[Random().nextInt(colors.length)];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: gameStarted ? AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ) : null,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              !gameStarted ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: () {
                if (!gameStarted) {
                  setState(() {
                    gameStarted = true;
                  });
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
                    !gameStarted ? "Start" : "60",
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
              ),
            ),
            if (gameStarted)
              SizedBox(height: 40,),
            if (gameStarted)
              Text("Find this color", style: TextStyle(color: Colors.black, fontSize: 30),),
            if (gameStarted)
              SizedBox(height: 10,),
            if (gameStarted)
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorToFind
                ),
              ),
            if (gameStarted)
              SizedBox(height: 20,),
            if (gameStarted)
              Expanded(
                child: GridView.count(crossAxisCount: widget.id + 3,
                physics: NeverScrollableScrollPhysics(),
                children: colorPad.map((color) {
                  return CupertinoButton(
                    onPressed: () {

                    },
                    minSize: 0,
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: color
                      ),
                    ),
                  );
                }).toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
