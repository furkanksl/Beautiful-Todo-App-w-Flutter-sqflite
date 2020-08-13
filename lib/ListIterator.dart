
import 'package:My_Todo_App/model/todo_item.dart';

abstract class IteratorMachine { // interface
  bool hasNext();
  String current();

}
class ListIterator implements IteratorMachine{
  List<ToDo_Item>  list ;
  int  index = 0;
  ListIterator(this.list);

  @override
  bool hasNext() {
    
    if(list.length -1  >= index){
       return true;
      
    }
    return false;
  }

  @override
  String current() {
    
      return list[index++].text;

  
  }


}

