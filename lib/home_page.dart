import 'package:color_game/game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text(
              "Choose difficulty",
              style: TextStyle(color: Colors.blueAccent, fontSize: 25),
            ),

            Expanded(
              child: ListView(
                children: difficulties.map((d) {
                  return CupertinoButton(
                    key: Key(d.id.toString()),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GamePage(id: d.id,)));
                    },
                    minSize: 0,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.blueAccent.withOpacity(0.3)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15,),
                            Text(d.title, style: TextStyle(color: Colors.white, fontSize: 26),),
                            Expanded(child: SizedBox(width: 50,)),
                            Text("(${d.difficulty})"),
                            SizedBox(width: 15,),
                          ],
                        ),
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

class DifficultyItem {
  String title;
  String difficulty;
  int id;

  DifficultyItem({this.title, this.difficulty, this.id});
}

List<DifficultyItem> difficulties = [
  DifficultyItem(
    title: "3x3",
    difficulty: "easy",
    id: 0,
  ),
  DifficultyItem(
    title: "4x4",
    difficulty: "medium",
    id: 1,
  ),
  DifficultyItem(
    title: "5x5",
    difficulty: "hard",
    id: 2,
  ),
];
