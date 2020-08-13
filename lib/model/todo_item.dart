

import 'package:flutter/material.dart';

class ToDo_Item {

  int _id;
  String _title;
  String _text;
  String _other;


  ///Setters and Getters

  int get id => _id;

  set id(int value){
    _id = value;
  }
  
    String get other => _other;

  set other(String other) {
    _other = other;
  }
 String get title => _title;

  set title(String title) {
    _title = title;
  }


  String get text => _text;

  set text(String value){
    _text = value;
  } 

  ToDo_Item(this._title , this._text , this._other);

  Map<String , dynamic> toMap(){

    var map = Map<String , dynamic>();
    map['id'] = _id;
    map['title'] = _title;
    map['text'] = _text;
    map['other'] = _other;

    return map;

  }

  ToDo_Item.fromMap(Map<String , dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._text = map['text'];
    this._other = map['other'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Todo{_id : $_id , text : $_text , other : $_other , title : $_title}';
  }

}