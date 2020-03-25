import 'package:My_Todo_App/main.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "My ToDo App",
      theme: ThemeData(
        primarySwatch: Colors.brown
      ),
      home: Home(),

    );
  }

}