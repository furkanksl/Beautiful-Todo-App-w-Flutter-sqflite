import 'package:My_Todo_App/education_notes.dart';
import 'package:My_Todo_App/other_notes.dart';
import 'package:My_Todo_App/shop_notes.dart';
import 'package:My_Todo_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Todo_App/notes.dart';
import 'package:intl/intl.dart';

import 'model/todo_item.dart';

//import 'main.darkjt';

void main() {
  runApp(MaterialApp(
    title: 'ToDo App Home',
    home: Home(),
    // color: Color.fromRGBO(172, 172, 172, 5),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0;

  TabController _tabController;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  DatabaseHelper databaseHelper;

  List<String> categoriesName = [
    "Tasks",
    "Shop Tasks",
    "Other Tasks",
    "Education Tasks"
  ];
  List<int> categoriesLen = [0, 0, 0, 0];

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);

    databaseHelper = DatabaseHelper();

    databaseHelper.allTodos().then((mapList) {
      setState(() {
        for (Map map in mapList) {
          categoriesLen[0]++;
        }
      });
    });
    databaseHelper.allTodosShop().then((mapList) {
      setState(() {
        for (Map map in mapList) {
          categoriesLen[1]++;
        }
      });
    });
    databaseHelper.allTodosOther().then((mapList) {
      setState(() {
        for (Map map in mapList) {
          categoriesLen[2]++;
        }
      });
    });

    databaseHelper.allTodosEdu().then((mapList) {
      setState(() {
        for (Map map in mapList) {
          categoriesLen[3]++;
        }
      });
    });
  }

  Widget _buildCategoryCard(int index, String title, int count) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotesListWidget()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopListWidget()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OtherListWidget()),
            );
          }
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EducationListWidget()),
            );
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 250.0,
        width: 250.0,
        decoration: BoxDecoration(
          color:
              _selectedCategoryIndex == index ? Colors.red : Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            _selectedCategoryIndex == index
                ? BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 10.0)
                : BoxShadow(color: Colors.transparent),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black, //0xFFAFB4C6
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                categoriesLen[index].toString(),
                style: TextStyle(
                  color: _selectedCategoryIndex == index
                      ? Colors.white
                      : Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = "ToDo App Home";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    double newheight = height - padding.top - padding.bottom;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      color: Colors.red,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Text(
                    'To-do',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: newheight - 70,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: categoriesName.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return SizedBox(width: 20.0);
                  }

                  return _buildCategoryCard(
                    index - 1,
                    categoriesName[index - 1],
                    categoriesLen[index - 1],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
