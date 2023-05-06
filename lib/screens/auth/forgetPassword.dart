import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/screens/auth/login.dart';
import 'package:techdo/screens/customWidget/inputField.dart';
import 'package:techdo/screens/customWidget/button.dart';
import 'package:techdo/screens/customWidget/toast.dart';

class forget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return forgetstate() ;
  }

}

class forgetstate extends State<forget>{
  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool showotp= false ;
  bool loading = false ;
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
                    (!showotp)?WriteHere(hint:'E-mail', controller: _email, readonly: false,):
                    Column(
                      children: [
                        WriteHere(hint: 'OTP', controller: _otp, readonly: false,),
                        WriteHere(hint: 'Password', controller: _password, readonly: false,),
                      ],
                    ),
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

                child: (!showotp)?ClickMe(title:'GET OTP', doing: ()async {
                  if (_email.text == '') {
                    showToast(context, "Input field can\'t be empty");
                  }
                  else {
                    await prder.OTPsend(_email.text);
                    setState(() {
                      showotp = true;
                    });
                  }
                },):
                    ClickMe(title: 'VALIDATE OTP AND SET PASSWORD', doing: ()async {
                      if (_otp.text == "" || _password.text == "") {
                        showToast(context, "Input field can\'t be empty");
                      }
                      else {
                        if (await prder.forgetpass(
                            _email.text, _password.text, _otp.text) == "true") {
                          Navigator.of(context).pushAndRemoveUntil(createRoute(
                              "login"), (Route<dynamic> route) => false);
                        }
                        else {
                          showToast(context, "OTP not correct");
                        }
                      }
                    }
                      ) ,
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