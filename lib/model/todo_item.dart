

class ToDo_Item {

  int _id;
  String _text;


  ///Setters and Getters

  int get id => _id;

  set id(int value){
    _id = value;
  }
  
  String get text => _text;

  set text(String value){
    _text = value;
  } 

  ToDo_Item(this._text);

  Map<String , dynamic> toMap(){

    var map = Map<String , dynamic>();
    map['id'] = _id;
    map['text'] = _text;

    return map;

  }

  ToDo_Item.fromMap(Map<String , dynamic> map){
    this._id = map['id'];
    this._text = map['text'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Todo{_id : $_id , text : $_text}';
  }

}