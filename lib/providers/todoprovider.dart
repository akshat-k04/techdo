import 'package:flutter/cupertino.dart';
import 'package:techdo/api/todoapi.dart';
import 'package:techdo/models/todomodel.dart';

class todoprovider with ChangeNotifier{
  List<todomdl> alltodos=[] ;
  List<todomdl> selectedDateTodohigh=[] ;
  List<todomdl> selectedDateTodomodarate=[] ;
  List<todomdl> selectedDateTodolow=[] ;
   int  ld=0 ,ln =0,md=0,mn=0,hd=0,hn=0 ;

  void percentagecalulator(){
    ld=0 ;ln=0;md=0;mn=0;hd=0;hn=0 ;
    for(var i in selectedDateTodolow){
      if(i.doneornot=='not'){
        ln++ ;
      }
      else{
        ld++ ;
      }
    }
    for(var i in selectedDateTodomodarate){
      if(i.doneornot=='not'){
        mn++ ;
      }
      else{
        md++ ;
      }
    }
    for(var i in selectedDateTodohigh){
      if(i.doneornot=='not'){
        hn++ ;
      }
      else{
        hd++ ;
      }
    }
}



  String selecteddate = (DateTime.now().month<10&&DateTime.now().day<10)?"${DateTime.now().year}-0${DateTime.now().month}-0${DateTime.now().day}":
  (DateTime.now().month>=10&&DateTime.now().day<10)?"${DateTime.now().year}-${DateTime.now().month}-0${DateTime.now().day}":
  (DateTime.now().month<10&&DateTime.now().day>=10)?"${DateTime.now().year}-0${DateTime.now().month}-${DateTime.now().day}":
  "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  void datemodifier(DateTime date){
    selecteddate = (date.month<10&&date.day<10)?"${date.year}-0${date.month}-0${date.day}":
    (date.month>=10&&date.day<10)?"${date.year}-${date.month}-0${date.day}":
    (date.month<10&&date.day>=10)?"${date.year}-0${date.month}-${date.day}":
    "${date.year}-${date.month}-${date.day}";

    notifyListeners() ;
    separate() ;
  }



  Future<void> getalltodos(String email,String hashmail )async {
    List<todomdl> cv =await todoapiservice.getdata(email, hashmail) ;
    alltodos = cv ;
    print(cv) ;
    separate() ;
    notifyListeners() ;
  }


  void separate () {
    selectedDateTodohigh = [];
    selectedDateTodolow = [];
    selectedDateTodomodarate = [];
    for (var i in alltodos) {
      if (selecteddate == i.date?.split(' ')[0]) {
        if (i.priority == "high") {
          selectedDateTodohigh.add(i);
        }
        else if (i.priority == "low") {
          selectedDateTodolow.add(i);
        }
        else {
          selectedDateTodomodarate.add(i);
        }
      }
      percentagecalulator() ;
      notifyListeners();
    }
  }
    Future<void> create(todomdl tod, String hashmail) async {
      alltodos.add(tod) ;
      separate() ;
      notifyListeners();
      await todoapiservice.addtodo(tod.email!, hashmail, tod);
    }

    Future<void> update(todomdl tod, String hashmail) async {
      // print(tod.unqid);
      int index = -1;
      for (var i in alltodos) {
        print(i.unqid);
        print(i.priority);
        if (i.unqid == tod.unqid) {
          index = alltodos.indexOf(i);
          break;
        }
      }
      // print(alltodos.firstWhere((element) => element.unqid== tod.unqid));
      // int index = alltodos.indexOf(alltodos.firstWhere((element) => element.unqid== tod.unqid));
      print(index);

      alltodos[index] = tod;
      separate();
      notifyListeners();

      await todoapiservice.updatetodo(tod.email!, hashmail, tod);
    }

    Future<void> delete(todomdl tod, String hashmail) async {
      int index = alltodos.indexOf(
          alltodos.firstWhere((element) => element.unqid == tod.unqid));
      alltodos.removeAt(index);
      separate();
      notifyListeners();

      await todoapiservice.deletetodo(tod.email!, hashmail, tod);
    }
  }