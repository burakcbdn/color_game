import 'package:color_game/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {

  final int score;

  const ResultPage({Key key, this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Game Over!", style: TextStyle(fontSize: 50),),
            SizedBox(height: 10,),
            Text("Your score is: $score", style: TextStyle(fontSize: 22),),

            SizedBox(height: 30,),
            CupertinoButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (context) => HomePage());
                Navigator.pushReplacement(context, route);
              },
              minSize: 0,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Material(
                borderRadius: BorderRadius.circular(25),
                elevation: 3,
                color: Colors.blueAccent,
                child: Container(
                  height: 56,
                  child: Center(
                    child: Text("Play Again", style: TextStyle(color: Colors.white, fontSize: 22),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
