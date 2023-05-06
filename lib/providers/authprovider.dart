import 'package:flutter/cupertino.dart';
import 'package:techdo/api/authapi.dart';
import 'package:techdo/models/authmodel.dart';

class authprovider with ChangeNotifier{
  String name="" ;
  String email = "" ;
  String hashmail = "" ;
  bool login = false ;


  Future<String> Userexistance(String email )async {
    String cv =await authapiservice.exist(email) ;
    return cv  ;
  }
  // true or false

  Future<void> OTPsend(String email )async {
    await authapiservice.SendOTP(email)  ;
  }
  //void
  Future<void> setemailHashmail(String Eml , String hashml)async {
    email=Eml ;
    hashmail=hashml ;
    notifyListeners() ;
  }

  Future<String> checkLogin(String Email , String password)async {

    var status = await authapiservice.login(Email, password)  ;
    if(status!="false"){
      login=true ;
      hashmail= status;
      email=Email ;
      notifyListeners() ;
    }
    return status ;
  }
  // hashmail or false

  Future<String> signup(String email , String password,String otp,String name)async {

    var status = await authapiservice.signup(email, name, password, otp)  ;
    return status ;
  }
  // true or false

  Future<String> forgetpass(String email , String password,String otp)async {

    var status = await authapiservice.forgetpass(email, password, otp)  ;
    return status ;
  }
  // true or false

Future<void> getit ()async{
    print(email) ;

  authmdl status = await authapiservice.getdata(email, hashmail)  ;
  name= status.name! ;
}

}