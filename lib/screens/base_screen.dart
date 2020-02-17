import 'package:flutter/material.dart';

class BaseScreens extends StatefulWidget {
  @override
  _BaseScreensState createState() => _BaseScreensState();
}

class _BaseScreensState extends State<BaseScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: Colors.pinkAccent,),
    );
  }
}
