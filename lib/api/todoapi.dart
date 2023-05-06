import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:techdo/models/todomodel.dart';


class todoapiservice {
  static String baseurl = "https://techdo-backend-service.onrender.com" ;


  static Future<List<todomdl>> getdata(String email , String hashmail)  async {

    Uri requestUri = Uri.parse("$baseurl/todo/get") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: todomdl(email: email, hashmail: hashmail ).getmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    var vali =decoded["bol"] ; //list of to do

    List<todomdl> temper = [] ;
    for(var i in vali){
      todomdl temp = todomdl(
        date: i["date"] ,
        email: i["email"],
        heading:i["heading"],
        details: i["details"],
        doneornot: i["doneornot"],
        priority: i["priority"],
        unqid: i["unqid"]
      ) ;
      temper.add(temp) ;
    }
    return temper ;
  }


  static Future<void> addtodo(String email , String hashmail , todomdl tim) async {
    Uri requestUri = Uri.parse("$baseurl/todo/add") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: todomdl(email: email, hashmail: hashmail,doneornot: tim.doneornot,details: tim.details,date: tim.date,heading: tim.heading,priority: tim.priority,unqid: tim.unqid ).todomap());
    print("recived data") ;
    // var decoded = jsonDecode(response.body);
}

  static Future<void> updatetodo(String email , String hashmail , todomdl tim) async {
    Uri requestUri = Uri.parse("$baseurl/todo/update") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: todomdl(email: email, hashmail: hashmail,doneornot: tim.doneornot,details: tim.details,date: tim.date,heading: tim.heading,priority: tim.priority,unqid: tim.unqid ).todomap());
    print("recived data") ;
    // var decoded = jsonDecode(response.body);
  }

  static Future<void> deletetodo(String email , String hashmail , todomdl tim) async {
    Uri requestUri = Uri.parse("$baseurl/todo/delete") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: todomdl(email: email, hashmail: hashmail,doneornot: tim.doneornot,details: tim.details,date: tim.date,heading: tim.heading,priority: tim.priority,unqid: tim.unqid ).todomap());
    print("recived data") ;
    // var decoded = jsonDecode(response.body);
  }

}