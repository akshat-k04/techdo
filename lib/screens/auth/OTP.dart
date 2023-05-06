import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/screens/auth/login.dart';
import 'package:techdo/screens/customWidget/inputField.dart';
import 'package:techdo/screens/customWidget/button.dart';
import 'package:techdo/screens/customWidget/progress%20indicator.dart';
import 'package:techdo/screens/customWidget/toast.dart';

class otp extends StatefulWidget {
  String name ;
  String email ;
  String password ;

  otp({super.key,required this.name,required this.password, required this.email});

  @override
  State<StatefulWidget> createState() {
    return otpstate() ;
  }

}

class otpstate extends State<otp>{
  final TextEditingController _otp = TextEditingController();
  bool fetch = false ;

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
                    WriteHere(hint: 'OTP', controller: _otp, readonly: fetch,),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              (fetch)?LoadingWidget():Container(
                // height: 100,
                margin: const EdgeInsets.all(20),
                decoration:  const BoxDecoration(
                  // color: Color(0xFFE5F9DB) ,
                  color: Color(0xFFDBDFEA),
                  borderRadius: BorderRadius.all(Radius.elliptical(40, 30)) ,
                  // border: Border.all(color: const Color(0xFFE5F9DB) ),
                ),

                child: ClickMe(title: 'VALIDATE OTP', doing: ()async{
                  if(_otp.text==""){
                    showToast(context, "Input field can\'t be empty");
                  }
                  else {
                    setState(() {
                      fetch=true ;
                    });
                    if (await prder.signup(
                        widget.email, widget.password, _otp.text,
                        widget.name) == 'true') {
                      setState(() {
                        fetch=false ;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          createRoute('login'), (Route<
                          dynamic> route) => false);
                    }
                    else {
                      showToast(context, "OTP not match");
                    }
                  }
                  setState(() {
                    fetch=false ;
                  });
                }) ,
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