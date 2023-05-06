import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techdo/main.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';
import 'package:techdo/screens/afterauth/HomeScreen.dart';
import 'package:techdo/screens/auth/login.dart';
import 'package:techdo/screens/customWidget/progress%20indicator.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return splashstate() ;
  }

}

class splashstate extends State<SplashScreen>{
  bool fetch = true ;
  @override
  void process ()async{
    authprovider prder = Provider.of<authprovider>(context,listen: false);
    todoprovider prdert = Provider.of<todoprovider>(context,listen: false);


    SharedPreferences sp = await SharedPreferences.getInstance();
    String? email =sp.getString('email') ;
    await Future.delayed( Duration(seconds: 1)) ;
    if(email!=null){
      String? hashmal = sp.getString('hashmail') ;
      await prder.setemailHashmail(email, hashmal!) ;
      await prder.getit() ;
      await prdert.getalltodos(email, hashmal!) ;
      setState(() {
        fetch=false ;
      });
      Navigator.of(context).pushAndRemoveUntil(createRoute(
          "home"), (Route<dynamic> route) => false);
    }
    else{
      Navigator.of(context).pushAndRemoveUntil(createRoute(
          "login"), (Route<dynamic> route) => false);
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    process() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: (fetch==true)?LoadingWidget():SizedBox(),
      ),
    ) ;
  }
  Route createRoute(String st) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      (st=="login")?loginpg():
      Home(),
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