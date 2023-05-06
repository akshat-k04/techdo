import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';
import 'package:techdo/screens/afterauth/createtodo.dart';
import 'package:techdo/screens/auth/login.dart';
import 'package:techdo/screens/customWidget/Dailysum.dart';
import 'package:techdo/screens/customWidget/colum.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState() ;
  }

}

class HomeState extends State<Home>{
  final CalendarWeekController _controller = CalendarWeekController();
  bool showcreate = false  ;
  @override
  Widget build(BuildContext context) {
    authprovider prder = Provider.of<authprovider>(context,listen: false);
    todoprovider prdertot = Provider.of<todoprovider>(context,listen: true);
    todoprovider prdertof = Provider.of<todoprovider>(context,listen: false);

    return WillPopScope(
      onWillPop: ()async {
        if(showcreate==true){
          setState(() {
            showcreate=false ;

          });
          return false ;
        }
        else{
          return true ;
        }
      },
      child: Stack(
        children:[
          Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF9BA4B5),
                    // Color(0xFFAFD3E2),
                    Color(0xFFF1F6F9)

                  ]

              )
          ),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF9BA4B5),
              onPressed: () {
                setState(() {
                  print(showcreate);
                  showcreate=!showcreate ;
                });
              },
              child: Icon(
                Icons.add,

              ),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Hello ${prder.name.split(" ")[0]}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF212A3E),
                          ),
                        ),

                      ),
                      IconButton(
                          onPressed: ()async{
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            sp.clear() ;
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> loginpg()),(Route<dynamic> route) => false) ;
                          },
                          icon: const Icon(Icons.logout_rounded)
                      )
                    ],
                  ) ,

                  const SizedBox(
                    height: 50,
                  ),
                  CalendarWeek(
                    // marginMonth: EdgeInsets.symmetric(vertical: 60),
                    // maxDate: DateTime.now().add(const Duration(days: 30)),
                    backgroundColor: Colors.transparent,
                    showMonth: false,
                    controller: _controller,
                    height: 100,
                    dateStyle: const TextStyle(
                      color: Color(0XFF394867),
                    ),
                    dayOfWeekStyle: const TextStyle(
                      color: Color(0XFF394867)
                    ),
                    pressedDateStyle: const TextStyle(
                        color: Color(0XFF212A3E),
                      fontWeight: FontWeight.bold
                    ),
                    pressedDateBackgroundColor: Colors.white54,
                    todayDateStyle:const TextStyle(
                        color: Color(0XFF394867)
                    ),
                    weekendsStyle: const TextStyle(
                      color:  Color(0XFF394867)
                    ),
                    onDatePressed: (DateTime datetime) {
                      // Do something
                      prdertof.datemodifier(datetime);
                      setState(() {

                      });
                    },
                  ),



                  const SizedBox(
                    height: 50,
                  ),
                  Smmary() ,
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 365,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(),
                          Text("HIGH PRIORITY",style: TextStyle(fontFamily: 'ubantu'),) ,
                          col(temper: prdertot.selectedDateTodohigh, priority: "high") ,
                          Text("MODARATE PRIORITY",style: TextStyle(fontFamily: 'ubantu'),) ,

                          col(temper: prdertot.selectedDateTodomodarate, priority: "modarate"),
                          Text("LOW PRIORITY",style: TextStyle(fontFamily: 'ubantu'),) ,

                          col(temper: prdertot.selectedDateTodolow, priority: 'low'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
          showcreate?createtodo():const SizedBox(),

      ]
      ),
    ) ;
  }

}