import 'package:My_Todo_App/education_notes.dart';
import 'package:My_Todo_App/model/todo_item.dart';
import 'package:My_Todo_App/shop_notes.dart';
import 'package:My_Todo_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Todo_App/main.dart';
import 'Animation/FadeAnimation.dart';
import 'package:My_Todo_App/Animation/animated_dialog_box.dart';
import 'dart:ui';


class OtherListWidget extends StatefulWidget {
  const OtherListWidget({Key key}) : super(key: key);
  @override
  OtherListWidgetState createState() => OtherListWidgetState();
}

class OtherListWidgetState extends State<OtherListWidget> {

  var formKey = GlobalKey<FormState>();

  String _title;
  String _note;
  String _other;

  String get note => _note;

  set note(String note) {
    _note = note;
  }

  String get title => _title;

  set title(String title) {
    _title = title;
  }

  String get other => _other;

  set other(String other) {
    _other = other;
  }

  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  DatabaseHelper databaseHelper;
  var txt = TextEditingController();
  var txt1 = TextEditingController();
  var txt2 = TextEditingController();
  var txt3 = TextEditingController();
  var txt4 = TextEditingController();
  var txt5 = TextEditingController();

  List<ToDo_Item> todoListOther;

  List<ToDo_Item> get todoListItems => todoListOther;

  List<String> data;
  int indexList = 0;

  //String submitText;
  @override
  void initState() {
    super.initState();

    todoListOther = List<ToDo_Item>();
    databaseHelper = DatabaseHelper();

    databaseHelper.allTodosOther().then((mapList) {
      for (Map map in mapList) {
        todoListOther.add(ToDo_Item.fromMap(map));

        print(ToDo_Item.fromMap(map));

        _listKey.currentState.insertItem(indexList++);
      }
    });

    // categories['Notes'] = len;
  }

  Future<int> _ekle(ToDo_Item item) async {
    // databaseHelper.deleteTable();

    await databaseHelper.addTodoOther(item).then((addInt) {
      setState(() {
        //todoList.add(item);
        item.id = addInt;

        todoListOther.insert(0, item);
        _listKey.currentState.insertItem(indexList++);
        //TodoItemIterator().getListItemTO();
      });
    });

    var result = await databaseHelper.allTodosEdu();
    // print(result);
    // databaseHelper.deleteTodo(4); // silme
  }

  Future<int> _update(ToDo_Item item, int index) async {
    //databaseHelper.deleteTable();

    await databaseHelper.updateTodo(item).then((addInt) {
      setState(() {
        item.id = addInt;

        todoListOther.insert(0, item);
        _listKey.currentState.insertItem(index);
      });
    });

    var result = await databaseHelper.allTodosEdu();
    // print(result);
    // databaseHelper.deleteTodo(4); // silme
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            'ToDo App',
            style: TextStyle(
                color: Colors.black, fontFamily: 'Roboto', fontSize: 20.0),
          ),
        ),
        body: AnimatedList(
          /// Key to call remove and insert item methods from anywhere
          key: _listKey,

          initialItemCount: todoListOther?.length ?? 0,
          itemBuilder: (context, index, animation) {
            return _buildItem(todoListOther[index], animation, index);
          },
        ),
        drawer: Container(
          width: 210,
          height: 550,
          child: Card(
            margin: EdgeInsets.all(0.0),
            elevation: 10.0,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.elliptical(50.0, 50.0),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.elliptical(50, 50),
              ),
            ),
            child: Drawer(
              child: Container(
                color: Colors.red,
                child: ListView(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(20.0),
                      elevation: 5.0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                       child: GestureDetector(
                          onTap: () async {
                            await animated_dialog_box.showRotatedAlert(
                              
                                title: Center(
                                  
                                  child: Text("Made by Fyrkerr",
                                  )
                                  ),
                                  // IF YOU WANT TO ADD
                                context: context,
                                firstButton: MaterialButton(
                                  // FIRST BUTTON IS REQUIRED
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  color: Colors.red,
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                icon: Icon(Icons.check,color: Colors.red,), // IF YOU WANT TO ADD ICON
                                yourWidget: Container(
                                  child: Text('Enjoy'),
                                ));
                
                                    
                          },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage("https://i.ibb.co/KFY229K/avatar-1.png"),
                          maxRadius: 28,
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          "Fyrkerr",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text("TODO",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    )
                ),
                    Card(
                      margin: EdgeInsets.all(20.0),
                      elevation: 5.0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: Text("Home",
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                          //You can add here a router
                        },
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(20.0),
                      elevation: 5.0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.grid_on,
                          color: Colors.white,
                        ),
                        title: Text("Shop Notes",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopListWidget()),
                          );
                          //You can add here a router
                        },
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(20.0),
                      elevation: 5.0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.grid_on,
                          color: Colors.white,
                        ),
                        title: Text("Other Notes",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtherListWidget()),
                          );
                          //You can add here a router
                        },
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(20.0),
                      elevation: 5.0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.grid_on,
                          color: Colors.white,
                        ),
                        title: Text("Education Notes",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EducationListWidget()),
                          );
                          //You can add here a router
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline, size: 70, color: Colors.white),

          backgroundColor: Colors.transparent,

          //foregroundColor: Colors.black,

          onPressed: () => settingModalBottomSheet(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildItem(ToDo_Item item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(27.0),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(width: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    todoListOther[index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    todoListOther[index].other,
                    //  _timeFormatter.format(todoList[index].id.toString()),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                todoListOther[index].text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      txt.text = todoListOther[index].title;
                      txt1.text = todoListOther[index].text;
                      txt2.text = todoListOther[index].other;

                      title = todoListOther[index].title;
                      note = todoListOther[index].text;
                      other = todoListOther[index].other;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            home: Scaffold(
                              body: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        colors: [
                                      Colors.red[900],
                                      Colors.red[800],
                                      Colors.red[400]
                                    ])),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          FadeAnimation(
                                              1,
                                              Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          FadeAnimation(
                                              1.3,
                                              Text(
                                                "New Note",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(60),
                                                topRight: Radius.circular(60))),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 80,
                                                ),
                                                FadeAnimation(
                                                    1.4,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        225,
                                                                        95,
                                                                        27,
                                                                        .3),
                                                                blurRadius: 20,
                                                                offset: Offset(
                                                                    0, 10))
                                                          ]),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Title",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  title = text;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt1,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Note",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  note = text;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt2,
                                                              maxLines: 1,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText: "",
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  other = text;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                FadeAnimation(
                                                    1.6,
                                                     GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (title !=
                                                                  null) {
                                                                var item =
                                                                    ToDo_Item(
                                                                        title,
                                                                        note,
                                                                        other);
                                                                title = "";
                                                                note = "";
                                                                other = "";

                                                                insertSingleItem(
                                                                    item);

                                                                var index2 =
                                                                    index;
                                                                print(index2);
                                                                print(
                                                                    indexList);
                                                                if (todoListOther
                                                                    .isNotEmpty) {
                                                                  print(todoListOther[
                                                                      index2]);

                                                                  databaseHelper
                                                                      .deleteTodo(
                                                                          todoListOther[index2]
                                                                              .id)
                                                                      .then(
                                                                          (deletedId) {
                                                                    setState(
                                                                        () {
                                                                      todoListOther.removeAt(
                                                                          indexList);
                                                                    });
                                                                  });

                                                                  _removeSingleItems(
                                                                      index);

                                                                  // print("buraaaada")
                                                                }

                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        "Cancel");
                                                              } else {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        "Cancel");
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        "Cancel");
                                                              }
                                                            });
                                                          },
                                                          child:
                                                    Container(
                                                      height: 50,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 50),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.red),
                                                      child: Center(
                                                        child: Text(
                                                            "Save",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                    fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    
                      
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showAlert(context, index);
                    },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }

  /// Method to add an item to an index in a list
  void insertSingleItem(ToDo_Item d) {
    _ekle(d);

    print("----Todo List İncludes : ------ ");

    getList(todoListOther);

    print("---- List End -----");
  }

///// Iterator Design Pattern function . Class is at the 632. line.
  getList(List list) {
    ListIterator listIterator = ListIterator(list);

    while (listIterator.moveNext()) {
      print(listIterator.current);
    }
  }

  /// Method to remove an item at an index from the list
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    indexList--;
    ToDo_Item removedItem = todoListOther.removeAt(removeIndex);
    // This builder is just so that the animation has something
    // to work with before it disappears from view since the original
    // has already been deleted.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // A method to build the Card widget.
      return _buildItem(removedItem, animation, removeAt);
    };

    _listKey.currentState.removeItem(removeIndex, builder);
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: CupertinoAlertDialog(
              title: new Text("DELETE!"),
              content: new Text(
                "Are you sure ?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    }),
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: new Text("Ok"),
                    onPressed: () {
                      var index2 = index;
                      print(index2);
                      print(indexList);
                      if (todoListOther.isNotEmpty) {
                        print(todoListOther[index2]);

                        databaseHelper
                            .deleteTodo(todoListOther[index2].id)
                            .then((deletedId) {
                          setState(() {
                            todoListOther.removeAt(indexList);
                          });
                        });
                      }
                      _removeSingleItems(index);

                      Navigator.pop(context, 'Cancel');
                      // call another functions here ---
                    })
              ],
            ),
          );
        });
  }

  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.red,
            child: new Wrap(
              children: <Widget>[
                new Card(
                  margin: EdgeInsets.all(20.0),
                  elevation: 5.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.elliptical(20.0, 20.0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.elliptical(20, 20),
                    ),
                  ),
                  child: ListTile(
                    leading: new Icon(Icons.add, color: Colors.black),
                    title: new Text(
                      'ADD',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return MaterialApp(
                            debugShowCheckedModeBanner: false,
                            home: Scaffold(
                              body: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        colors: [
                                      Colors.red[900],
                                      Colors.red[800],
                                      Colors.red[400]
                                    ])),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          FadeAnimation(
                                              1,
                                              Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 40),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          FadeAnimation(
                                              1.3,
                                              Text(
                                                "New Note",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(60),
                                                topRight: Radius.circular(60))),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 80,
                                                ),
                                                FadeAnimation(
                                                    1.4,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        225,
                                                                        95,
                                                                        27,
                                                                        .3),
                                                                blurRadius: 20,
                                                                offset: Offset(
                                                                    0, 10))
                                                          ]),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt3,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Title",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  title = text;
                                                                  txt3 =null;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt4,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Note",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  note = text;
                                                                  txt4=null;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[200]))),
                                                            child: TextField(
                                                              controller: txt5,
                                                              decoration: InputDecoration(
                                                                  hintText:
                                                                      "Other , Cost , important etc.",
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  
                                                                  other = text;
                                                                  txt5= null;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                FadeAnimation(
                                                  
                                                    1.6,
                                                    GestureDetector(
                                                          onTap: () {
                                                           
                                                            setState(() {

                                                            

                                                              if((title != null && note != null && other != null )&& (title != '' && note != '' && other != ' ' )) {
                                                                print(txt.text);
                                                                var item = ToDo_Item(title,note,other);
                                                               
                                                                title = null;
                                                                note = null;
                                                                 other = null;

                                                                 

                                                                insertSingleItem(
                                                                    item);

                                                                Navigator.pop(
                                                                    context);
                                                              }else{
                                                                 Navigator.pop(
                                                                    context);
                                                              }
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop("Cancel");
                                                          },
                                                          child:
                                                    Container(
                                                      height: 50,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 50),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.red),
                                                      child: Center(
                                                        
                                                          child: Text(
                                                            "Save",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                    fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    /*
                            Expanded(
                              child: FadeAnimation(1.8, Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue
                                ),
                                child: Center(
                                  child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: FadeAnimation(1.9, Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black
                                ),
                                child: Center(
                                  child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            ) */
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );

                      //Navigator.of(context).pop("Cancel");
                    },
                  ),
                ),
                new Card(
                  margin: EdgeInsets.all(20.0),
                  elevation: 5.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.elliptical(20.0, 20.0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.elliptical(20, 20),
                    ),
                  ),
                  child: ListTile(
                    leading: new Icon(
                      Icons.block,
                      color: Colors.black,
                    ),
                    title: new Text('CANCEL'),
                    onTap: () {
                      Navigator.of(context).pop("Cancel");
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

//   void showCupertinoSheet() {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         title: Text(
//           "---Options---",
//           style: TextStyle(
//               color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         //message: Text(
//         //"Choose an option ",
//         // style: TextStyle(color: Colors.black),
//         // ),
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(
//               "Add",
//               style: TextStyle(color: Colors.black),
//             ),
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   CupertinoPageRoute(builder: (context) => AddPage() ),
//                 );

//               Navigator.of(context).pop("Cancel");
//             },
//             isDefaultAction: true,
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.red),
//           ),
//           onPressed: () => Navigator.of(context).pop("Cancel"),
//           isDestructiveAction: true,
//         ),
//       ),

//       ///Getting the chosen option value from sheet here
//     ).then(
//       (option) {
//         if (option != null) {
//           _scaffoldKey.currentState.showSnackBar(
//             SnackBar(
//               content: Text("Success"),
//               duration: Duration(milliseconds: 1000),
//             ),
//           );
//         }
//       },
//     );
//   }

// }

}

///// Iterator Design Pattern Class
class ListIterator implements Iterator {
  var _tempList;

  ListIterator(this._tempList);

  var _index = 0;
  get current => _tempList[_index++].text;
  bool moveNext() => _index < _tempList.length;
}
