const adapteeMessage = 'important';

class Adaptee {
  String method() {
    return adapteeMessage;
  }
}

abstract class AddSignature {
  String addSignature();
}

class Adapter implements AddSignature {
  String addSignature() {
    var adaptee = Adaptee();
   
    return adaptee.method();
  }
}

String addKeywords(String todoText) {
  var adapter = Adapter();
  var result = adapter.addSignature();

  todoText = result + "\n" +todoText;

  return todoText;
  
}