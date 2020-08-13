import 'package:My_Todo_App/education_notes.dart';
import 'package:My_Todo_App/model/todo_item.dart';
import 'package:My_Todo_App/other_notes.dart';
import 'package:My_Todo_App/shop_notes.dart';
import 'package:My_Todo_App/utils/database_helper.dart';
import 'package:My_Todo_App/utils/ui_helpers.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Todo_App/main.dart';
import 'package:My_Todo_App/Animation/animated_dialog_box.dart';
import 'Animation/FadeAnimation.dart';
import 'dart:ui';
import 'package:My_Todo_App/ListIterator.dart';

class NotesListWidget extends StatefulWidget {
  const NotesListWidget({Key key}) : super(key: key);
  @override
  AnimatedListWidgetState createState() => AnimatedListWidgetState();
}

class AnimatedListWidgetState extends State<NotesListWidget> {
  var formKey = GlobalKey<FormState>();

  ListIterator itr;
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

  List<ToDo_Item> todoList;

  List<ToDo_Item> get todoListItems => todoList;

  List<String> data;
  int indexList = 0;

  //String submitText;
  @override
  void initState() {
    super.initState();

    todoList = List<ToDo_Item>();
    databaseHelper = DatabaseHelper();

    databaseHelper.allTodos().then((mapList) {
      for (Map map in mapList) {
        todoList.add(ToDo_Item.fromMap(map));

        print(ToDo_Item.fromMap(map));

        _listKey.currentState.insertItem(indexList++);
      }
    });

    // categories['Notes'] = len;
  }

  Future<int> _ekle(ToDo_Item item) async {
    // databaseHelper.deleteTable();

    await databaseHelper.addTodoNotes(item).then((addInt) {
      setState(() {
        //todoList.add(item);
        item.id = addInt;

        todoList.insert(0, item);
        _listKey.currentState.insertItem(indexList++);
        //TodoItemIterator().getListItemTO();
      });
    });

    var result = await databaseHelper.allTodos();
    // print(result);
    // databaseHelper.deleteTodo(4); // silme
  }

  Future<int> _update(ToDo_Item item, int index) async {
    //databaseHelper.deleteTable();

    await databaseHelper.updateTodo(item).then((addInt) {
      setState(() {
        item.id = addInt;

        todoList.insert(0, item);
        _listKey.currentState.insertItem(index);
      });
    });

    var result = await databaseHelper.allTodos();
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

          initialItemCount: todoList?.length ?? 0,
          itemBuilder: (context, index, animation) {
            return _buildItem(todoList[index], animation, index);
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
                                    child: Text(
                                  "Made by Fyrkerr",
                                )),
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
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.red,
                                ), // IF YOU WANT TO ADD ICON
                                yourWidget: Container(
                                  child: Text('Enjoy'),
                                ));
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://i.ibb.co/KFY229K/avatar-1.png"),
                              maxRadius: 28,
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                              "Fyrkerr",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text("TODO",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          ),
                        )),
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
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return Material(
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(0.0, 1.0),
                      ).animate(secondaryAnimation),
                      child: child,
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 700),
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  Stack(
                children: <Widget>[
                  Hero(
                    tag: 'tile0',
                    child: Container(
                      child: Material(
                        color: Colors.black38,
                        elevation: 5.0,
                        shadowColor: Colors.black38,
                        child: InkWell(
                          splashColor: Colors.black,
                          child: null,
                          onTap: doNothing,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Hero(
                      tag: 'elt1',
                      child: Container(
                        width: 00,
                        height: 00,
                        child: FlareActor(
                          'assets/flare/card.flr',
                          animation: 'animation',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    height: 600.0,
                    width: 550.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 10.0)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 0),
                          child: Text(
                            "Title : " + todoList[index].title,
                            style: TextStyle(
                              color: Colors.black, //0xFFAFB4C6
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, top: 0, bottom: 100, right: 10),
                          child: Text(
                            "Task : " + todoList[index].text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 15.0,
                    right: 15.0,
                    child: FloatingActionButton(
                      heroTag: 'elt2',
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      elevation: 5.0,
                      child: Icon(EvaIcons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
                      todoList[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      todoList[index].other,
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
                  todoList[index].text,
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
                        txt.text = todoList[index].title;
                        txt1.text = todoList[index].text;
                        txt2.text = todoList[index].other;

                        var title = todoList[index].title;
                        var note = todoList[index].text;
                        var other = todoList[index].other;

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  topRight:
                                                      Radius.circular(60))),
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
                                                                    .circular(
                                                                        10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          225,
                                                                          95,
                                                                          27,
                                                                          .3),
                                                                  blurRadius:
                                                                      20,
                                                                  offset:
                                                                      Offset(0,
                                                                          10))
                                                            ]),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Colors.grey[200]))),
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
                                                                    title =
                                                                        text;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Colors.grey[200]))),
                                                              child: TextField(
                                                                controller:
                                                                    txt1,
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
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              Colors.grey[200]))),
                                                              child: TextField(
                                                                controller:
                                                                    txt2,
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
                                                                    other =
                                                                        text;
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
                                                            if (txt.text ==
                                                                    '' ||
                                                                txt1.text ==
                                                                    '' ||
                                                                txt2.text ==
                                                                    '') {
                                                              title = "empty";
                                                              note = "empty";
                                                              other = "empty";
                                                            } else {
                                                              title = txt.text;
                                                              note = txt1.text;
                                                              other = txt2.text;
                                                            }

                                                            if (title != '' &&
                                                                note != '' &&
                                                                other != '') {
                                                              print(txt.text);
                                                              var item =
                                                                  ToDo_Item(
                                                                      title,
                                                                      note,
                                                                      other);

                                                              insertSingleItem(
                                                                  item);

                                                              var index2 =
                                                                  index;
                                                              print(index2);
                                                              print(indexList);
                                                              if (todoList
                                                                  .isNotEmpty) {
                                                                print(todoList[
                                                                    index2]);

                                                                databaseHelper
                                                                    .deleteTodo(
                                                                        todoList[index2]
                                                                            .id)
                                                                    .then(
                                                                        (deletedId) {
                                                                  setState(() {
                                                                    todoList.removeAt(
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
                                                        child: Container(
                                                          height: 50,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      50),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.red),
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
                                                    children: <Widget>[],
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
      ),
    );
  }

  /// Method to add an item to an index in a list
  void insertSingleItem(ToDo_Item d) {
    _ekle(d);
    getTheList();
  }

  void getTheList() {
    ListIterator itr = ListIterator(
        todoList); // interface i implement eden class tan nesne oluşturuluyor.
    print("******Animated List Include that things*******");
    setState(() {
      while (itr.hasNext()) {
        print(itr.current());
      }
    });

    print("*****END OF THE ANIMATED LIST ******");
  }

  /// Method to remove an item at an index from the list
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    indexList--;
    ToDo_Item removedItem = todoList.removeAt(removeIndex);
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
                      if (todoList.isNotEmpty) {
                        print(todoList[index2]);

                        databaseHelper
                            .deleteTodo(todoList[index2].id)
                            .then((deletedId) {
                          setState(() {
                            if (indexList >= 0) {
                              todoList.removeAt(indexList);
                            }
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
                                                                        3),
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
                                                                  txt3 = null;
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
                                                                  txt4 = null;
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
                                                                      "Other , Cost etc.",
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
                                                                  txt5 = null;
                                                                });
                                                              },
                                                            ),
                                                          ), /*
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                note =
                                                                    addKeywords(
                                                                        note);
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          50),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  color: Colors
                                                                      .red),
                                                              child: Center(
                                                                child: Text(
                                                                  "Add Important Keyword",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),*/
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
                                                          if ((title != null &&
                                                                  note !=
                                                                      null &&
                                                                  other !=
                                                                      null) &&
                                                              (title != '' &&
                                                                  note != '' &&
                                                                  other !=
                                                                      ' ')) {
                                                            print(txt.text);
                                                            var item =
                                                                ToDo_Item(
                                                                    title,
                                                                    note,
                                                                    other);

                                                            title = null;
                                                            note = null;
                                                            other = null;

                                                            insertSingleItem(
                                                                item);

                                                            Navigator.pop(
                                                                context);
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });

                                                        Navigator.of(context)
                                                            .pop("Cancel");
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 50),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
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
                                                  children: <Widget>[],
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
}

///// Iterator Design Pattern Class
