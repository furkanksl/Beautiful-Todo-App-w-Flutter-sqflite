 //import 'package:flutter/material.dart';

// Behavioral Design Pattern has been used (Iterator)
class ListIterator implements Iterator {

  var _tempList ;

  ListIterator(this._tempList);

  var _index = 0;
  get current => _tempList[_index++];
  bool moveNext() => _index < _tempList.length;
}


getList(List list){

ListIterator listIterator = ListIterator(list);

  while(listIterator.moveNext()) {
    print(listIterator.current);
  }

}
////////////////////////////////////////////////////



