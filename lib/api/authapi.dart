import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:techdo/models/authmodel.dart';


class authapiservice {
  static String baseurl = "https://techdo-backend-service.onrender.com" ;


  static Future<String> login(String email , String pass)  async {

    Uri requestUri = Uri.parse("$baseurl/auth/login") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: authmdl(email: email,password: pass).loginmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    return decoded["bol"] ; //hashmail or false
  }
  // return the hashmail

  static Future<String> exist(String email)  async {

    Uri requestUri = Uri.parse("$baseurl/auth/check") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: authmdl(email: email).existmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    return decoded["bol"] ; //true or false
  }
  // return the true or false

  static Future<String> signup(String email,String name , String password , String otp)  async {

    Uri requestUri = Uri.parse("$baseurl/auth/signup") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: authmdl(email: email,name: name , otp: otp,password: password).signupmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    return decoded["bol"] ; //true or false
  }
  // return the true or false

  static Future<String> forgetpass(String email, String otp,String password)  async {

    Uri requestUri = Uri.parse("$baseurl/auth/forgetpassword") ;
    print("getting data") ;
    var response = await http.post(requestUri,body: authmdl(email: email, otp: otp,password: password).forgetmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    print(otp) ;
    print(email) ;

    return decoded["bol"] ; //true or false
  }
  // return the true or false

  static Future<authmdl> getdata(String email,var hashmail)  async {

    Uri requestUri = Uri.parse("$baseurl/auth/getdata") ;
    print("getting data") ;
    // var mp = authmdl(email: email,hashmail: hashmail).getmap() ;
    // print(mp);
    var response = await http.post(requestUri,body: authmdl(email: email,hashmail: hashmail).getmap());
    print("recived data") ;
    var decoded = jsonDecode(response.body);
    if(decoded["bol"]=="false"){
      // print(decoded) ;print("HII") ;
      authmdl mh = authmdl(name: 'no') ;
      return mh ;
    }
    else if (decoded["bol"]==false){
      authmdl mh = authmdl(name: 'no') ;
      return mh ;
    }
    else {
      authmdl mh = authmdl(name: decoded['bol']["name"]) ;
      return mh ;
    }
  }
  // return the data or false(hash not correct) or bool false (data not fount)


  static Future<void> SendOTP(String Email) async{
    Uri requestUri = Uri.parse("$baseurl/otp/send") ;
    var response = await http.post(requestUri,body: authmdl(email: Email).otpmap());
    // var decoded = jsonDecode(response.body);

    // print(decoded["bol"]) ; // print done if send
  }
  // void
}