import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/screens/auth/OTP.dart';
import 'package:techdo/screens/customWidget/inputField.dart';
import 'package:techdo/screens/customWidget/button.dart';
import 'package:techdo/screens/customWidget/toast.dart';

class signuppg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginstate() ;
  }

}

class loginstate extends State<signuppg>{
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _confpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    authprovider prder = Provider.of<authprovider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,

          ),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ) , //upper space
              const SizedBox(
                height: 200,
                width: 200,
                child: Image(  image: AssetImage("assets/image/signup.jpg"),),
              ),// image
              const SizedBox(height: 30,),
              Container(

                margin: const EdgeInsets.all(30),
                decoration:  const BoxDecoration(
                  color: Color(0xFFCCD6A6) ,

                  // color: Color(0xFFDBDFEA),
                  // color:  Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 30)) ,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    WriteHere(hint:'Name', controller: _name, readonly: false,),
                    WriteHere(hint:'E-mail', controller: _email, readonly: false,),
                    WriteHere(hint:'Password', controller: _password, readonly: false,),
                    WriteHere(hint: 'Confirm Password', controller: _confpassword, readonly: false,) ,
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ), //info page
              ),

              Container(
                // height: 100,
                margin: const EdgeInsets.all(20),
                decoration:  const BoxDecoration(
                  color: Color(0xFFCCD6A6) ,
                  // color: Color(0xFFDBDFEA),
                  // color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 30)) ,
                  // border: Border.all(color: const Color(0xFFE5F9DB) ),
                ),

                child: ClickMe(title: 'GET OTP', doing: ()async {
                  if (_email.text == "" || _password.text == ""|| _name.text=="" || _confpassword.text=="") {

                    showToast(context, 'input field can\'t be empty');
                  }
                  else if(!EmailValidator.validate(_email.text)){
                    showToast(context, 'Enter a valid email address');
                  }
                  else if (_password.text!= _confpassword.text){
                    showToast(context, 'password not match with confirm password');

                  }
                  else {
                    if (await prder.Userexistance(_email.text) == 'true') {
                      showToast(context, 'user already exist');
                    }
                    else {
                      await prder.OTPsend(_email.text);
                      Navigator.of(context).push(createRoute("otp"));
                    }
                  }

                },)  ,
              ), //button

            ],
          ),
        ),
      ),
    ) ;
  }
  Route createRoute(String st) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          otp(name: _name.text, password: _password.text, email: _email.text,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}