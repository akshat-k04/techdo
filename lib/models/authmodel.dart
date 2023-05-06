class authmdl {
  String? email ;
  String? password ;
  String ? name ;
  String ? hashmail ;
  String? otp ;
  authmdl({this.email , this.password,this.name,this.hashmail,this.otp}) ; // object

  Map<String,dynamic> loginmap(){
    return {
      "email": email ,
      "password":password
    };
  }
  Map<String,dynamic> signupmap(){
    return {
      "email": email ,
      "password":password,
      "otp": otp ,
      "name": name
    };
  }
  Map<String,dynamic> forgetmap(){
    return {
      "email": email ,
      "password":password,
      "otp": otp
    };
  }
  Map<String,dynamic> existmap(){
    return {
      "email": email
    };
  }
  Map<String,dynamic> getmap(){
    return {
      "email": email,
      "hashmail": hashmail
    };
  }
  Map<String,dynamic> otpmap(){
    return {
      "email": email,
    };
  }
}