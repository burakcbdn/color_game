import 'package:color_game/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ColorGame());
}

class ColorGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
