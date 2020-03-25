
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Todo_App/home.dart';

//import 'main.dart';

void main() {
  runApp(MaterialApp(
    title: 'ToDo App Home',
    home: Home(),
    // color: Color.fromRGBO(172, 172, 172, 5),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "ToDo App Home";

    List<Choice> choices = const <Choice>[
      const Choice(
          title: 'MY TASKS',
          date: '',
          description: ' ',
          imglink: 'https://i.ibb.co/4mRF67b/clipboard.png'),
      
    ];

    return MaterialApp(
      title: title,
      color: Colors.red,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromRGBO(172, 172, 172, 87),
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.brown,
          child:  ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: List.generate(
                choices.length,
                (index) {
                  return Center(
                    child: ChoiceCard(
                        choice: choices[index], item: choices[index]),
                  );
                },
              ),
            ),
         
        
      ),),
    );
  }
}

class Choice {
  final String title;
  final String date;
  final String description;
  final String imglink;

  const Choice({this.title, this.date, this.description, this.imglink});
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
      this.choice,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Container(
      child : GestureDetector(
          onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimatedListWidget()),
                );
              },
      child: Card(
        
        margin: const EdgeInsets.only(
            left: 10.0, right: 0.0, bottom: 50.0, top: 350.0),
        elevation: 5.0,
        color: Color.fromRGBO(176, 161, 155, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.elliptical(20.0, 20.0),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.elliptical(20, 20),
          ),
        ),
        child : GestureDetector(
          onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimatedListWidget()),
                );
              },
        child: Column(
          children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimatedListWidget()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Image.network(choice.imglink),
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: 300,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(choice.title,
                        style: Theme.of(context).textTheme.title),
                    Text(choice.date,
                        style: TextStyle(color: Colors.black.withOpacity(0.5))),
                    Text(choice.description),
                  ],
                ),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      ),
      ),
    );
  }
}
