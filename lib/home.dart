import 'package:My_Todo_App/model/todo_item.dart';
import 'package:My_Todo_App/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:My_Todo_App/main.dart';
import 'beauty_textfield.dart';
import 'dart:ui';

//void main() => runApp(MaterialApp(
//    home: AnimatedListWidget(),
// ));

class AnimatedListWidget extends StatefulWidget {
  const AnimatedListWidget({Key key}) : super(key: key);
  @override
  AnimatedListWidgetState createState() => AnimatedListWidgetState();
}

class AnimatedListWidgetState extends State<AnimatedListWidget> {
  // the GlobalKey is needed to animate the list
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper;
  var txt = TextEditingController();
  List<ToDo_Item> todoList;
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
  }

  Future<int> _ekle(ToDo_Item item) async {
    //databaseHelper.deleteTable();

    await databaseHelper.addTodo(item).then((addInt) {
      setState(() {
        //todoList.add(item);
        item.id = addInt;
        todoList.insert(0, item);
        _listKey.currentState.insertItem(indexList++);
      });
    });

    var result = await databaseHelper.allTodos();
    print(result);
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
    print(result);
    // databaseHelper.deleteTodo(4); // silme
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(172, 172, 172, 67),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(172, 172, 172, 67),
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
          height: 350,
          child: Card(
            margin: EdgeInsets.all(0.0),
            elevation: 10.0,
            color: Color.fromRGBO(176, 161, 155, 5),
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
                color: Colors.grey.withOpacity(1),
                child: ListView(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(20.0),
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
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://i.ibb.co/Y2TWdgM/user.png"),
                          maxRadius: 35,
                          backgroundColor: Color.fromRGBO(172, 172, 172, 80),
                        ),
                        title: Text("Fyrkerr"),
                        subtitle: Text("TODO"),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(20.0),
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
                      child: ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Home"),
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
                      color: Color.fromRGBO(176, 161, 155, 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.elliptical(20.0, 20.0),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.elliptical(20, 20),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.grid_on),
                        title: Text("Products"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
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
          child: Icon(Icons.add_circle_outline, size: 60, color: Colors.black),

          backgroundColor: Colors.transparent,

          //foregroundColor: Colors.black,

          onPressed: () => settingModalBottomSheet(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildItem(ToDo_Item item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: EdgeInsets.all(20.0),
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
        child: Container(
          height: 100.0,
          // margin: const EdgeInsets.only(left: 50.0, right: 0.0 , bottom: 0.0 , top: 10.0),
          alignment: Alignment.topRight,

          child: new Container(
            child: new ListTile(
              title: Text(
                item.text,
                style: TextStyle(fontSize: 20),
              ),
              trailing: Wrap(
                  spacing: 19,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new GestureDetector(
                      child: Container(
                        //alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        showAlert(context, index);
                      },
                    ),
                    new GestureDetector(
                      child: Container(
                        //alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        txt.text = todoList[index].text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MaterialApp(
                              home: Scaffold(
                                backgroundColor:
                                    Color.fromRGBO(172, 172, 172, 67),
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Add New ToDo',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(172, 172, 172, 67),
                                ),
                                body: Container(
                                    color: Color.fromRGBO(172, 172, 172, 67),
                                    margin: const EdgeInsets.only(
                                        left: 0.0,
                                        right: 0.0,
                                        bottom: 0.0,
                                        top: 00.0),
                                    padding: EdgeInsets.only(top: 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Form(
                                          key: formKey,
                                          child: BeautyTextfield(
                                            width: double.maxFinite,
                                            height: 100,
                                            controller: txt,
                                            duration:
                                                Duration(milliseconds: 300),
                                            inputType: TextInputType.text,
                                            prefixIcon: Icon(
                                              Icons.text_fields,
                                              color: Colors.black,
                                            ),
                                            placeholder: "Type here",
                                            onSubmitted: (d) {
                                              var item = ToDo_Item(d);
                                              if (formKey.currentState
                                                  .validate()) {
                                                formKey.currentState.save();
                                                insertSingleItem(item);

                                                  }
                                                var index2 = index;
                                                print(index2);
                                                print(indexList);
                                                if (todoList.isNotEmpty) {
                                                  print(todoList[index2]);

                                                  databaseHelper
                                                      .deleteTodo(
                                                          todoList[index2].id)
                                                      .then((deletedId) {
                                                    setState(() {
                                                      todoList
                                                          .removeAt(indexList);
                                                    });
                                                  });
                                                
                                                _removeSingleItems(index);

                                                

                                                print("buraaaada");
                                              }
                                            
                                              Navigator.push(
                                              context,
                                                MaterialPageRoute(builder: (context) => AnimatedListWidget()));
                                              Navigator.pop(context);
                                              Navigator.of(context)
                                                  .pop("Cancel");
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  /// Method to add an item to an index in a list
  void insertSingleItem(ToDo_Item d) {
    _ekle(d);

    print("burayada girdi");
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
                            todoList.removeAt(indexList);
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
            color: Color.fromRGBO(172, 172, 172, 67),
            child: new Wrap(
              children: <Widget>[
                new Card(
                  margin: EdgeInsets.all(20.0),
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
                            home: Scaffold(
                              backgroundColor:
                                  Color.fromRGBO(172, 172, 172, 67),
                              appBar: AppBar(
                                centerTitle: true,
                                title: Text(
                                  'Add New ToDo',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor:
                                    Color.fromRGBO(172, 172, 172, 67),
                              ),
                              body: Container(
                                  color: Color.fromRGBO(172, 172, 172, 67),
                                  margin: const EdgeInsets.only(
                                      left: 0.0,
                                      right: 0.0,
                                      bottom: 0.0,
                                      top: 00.0),
                                  padding: EdgeInsets.only(top: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Form(
                                        key: formKey,
                                        child: BeautyTextfield(
                                          width: double.maxFinite,
                                          height: 100,
                                          duration: Duration(milliseconds: 300),
                                          inputType: TextInputType.text,
                                          prefixIcon: Icon(
                                            Icons.text_fields,
                                            color: Colors.black,
                                          ),
                                          placeholder: "Type here",
                                          onSubmitted: (d) {
                                            var item = ToDo_Item(d);
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();
                                              insertSingleItem(item);
                                              print("buraaaada");
                                            }

                                            Navigator.pop(context);
                                            Navigator.of(context).pop("Cancel");
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
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
                  color: Color.fromRGBO(176, 161, 155, 5),
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
