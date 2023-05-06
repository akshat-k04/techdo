import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';
import 'package:techdo/screens/afterauth/HomeScreen.dart';
import 'package:techdo/screens/auth/forgetPassword.dart';
import 'package:techdo/screens/auth/signup.dart';
import 'package:techdo/screens/customWidget/inputField.dart';
import 'package:techdo/screens/customWidget/button.dart';
import 'package:techdo/screens/customWidget/toast.dart';

class loginpg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginstate() ;
  }

}

class loginstate extends State<loginpg>{
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    authprovider prder = Provider.of<authprovider>(context,listen: false);
    todoprovider prdert = Provider.of<todoprovider>(context,listen: false);

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
                height: 100,
              ) , //upper space
              const SizedBox(
                height: 200,
                width: 200,
                child: Image(  image: AssetImage("assets/image/login.jpg"),),
              ),// image
              const SizedBox(height: 40,),
              Container(

                margin: const EdgeInsets.all(20),
                decoration:  const BoxDecoration(
                  // color: Color(0xFFE5F9DB) ,
                  color: Color(0xFFDBDFEA),
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 30)) ,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    WriteHere(hint:'E-mail', controller: _email, readonly: false,),
                    WriteHere(hint: 'Password', controller: _password, readonly: false,) ,
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              Container(
                // height: 100,
                margin: const EdgeInsets.all(20),
                decoration:  const BoxDecoration(
                  // color: Color(0xFFE5F9DB) ,
                  color: Color(0xFFDBDFEA),
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 30)) ,
                  // border: Border.all(color: const Color(0xFFE5F9DB) ),
                ),

                child: ClickMe(title: 'submit', doing: () async {
                  if (_email.text == "" || _password.text == "") {

                    showToast(context, 'input field can\'t be empty');
                  }
                  else if(!EmailValidator.validate(_email.text)){
                    showToast(context, 'Enter a valid email address');
                  }
                  else {
                    if (await prder.Userexistance(_email.text) == 'true') {
                      var tp =await prder.checkLogin(_email.text, _password.text) ;
                      if (tp =='false') {
                        showToast(context, 'wrong password!');
                      }
                      else {
                        //get data
                        await prder.getit();
                        SharedPreferences sp = await SharedPreferences.getInstance();
                        sp.setString('email', _email.text);
                        sp.setString('hashmail',tp);
                        prdert.getalltodos(_email.text, tp) ;
                        Navigator.of(context).pushAndRemoveUntil(createRoute("home"), (Route<dynamic> route) => false);
                      }
                    }
                    else {
                      showToast(context, 'user not exist');
                    }
                  }
                }
                ),
              ),


              TextButton(
                  onPressed: (){

                    Navigator.of(context).push(createRoute("forget"));
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9BA4B5),
                        fontFamily: "ubantu"
                    ),
                  )
              ),

              // const SizedBox(
              //   height: 10.0,
              // ),
              const Text(
                'OR',
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFD9D9D9),
                    fontFamily: "ubantu"
                ),
              ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(createRoute("signup"));
                  },
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 15.5,
                      fontFamily: "ubantu",
                      color: Color(0xFF9BA4B5),
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    ) ;
  }
  Route createRoute(String st) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      (st=="signup")?signuppg():
      (st=="forget")? forget():
      (st=='home')? Home() :
      loginpg(),
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