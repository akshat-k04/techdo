import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:techdo/providers/todoprovider.dart';

class Smmary extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return sumstate() ;
  }

}

class sumstate extends State<Smmary>{
  @override
  Widget build(BuildContext context) {
    todoprovider prdertot = Provider.of<todoprovider>(context,listen: true);
    double frac = (prdertot.hn+prdertot.mn+prdertot.ln+prdertot.ld+prdertot.md+prdertot.hd!=0)?((prdertot.ld+prdertot.md+prdertot.hd)/(prdertot.hn+prdertot.mn+prdertot.ln+prdertot.ld+prdertot.md+prdertot.hd)):0.0 ;
    int pers = (frac*100).round() ;

    return Container(
      height: 110,
      decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child:Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('${_controller.selectedDate.day}'),
          SizedBox(
            width: 17,
          ),
          CircularPercentIndicator(
            radius: 42.0,
            lineWidth: 9.0,
            animation: true,
            percent: frac ,
            center: Text(
              "${pers}%",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            // footer: const Text(
            //   "Sales this week",
            //   style:
            //   TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            // ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor:   Color(0XFF212A3E),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              const Text('PRIORITY',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("HIGH",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 3,
                      ),
                      Text('${prdertot.hd}/${prdertot.hn+prdertot.hd}'),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Column(
                    children:  [
                      Text("MODRATE",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 3,
                      ),
                      Text('${prdertot.md}/${prdertot.mn+prdertot.md}'),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),

                  Column(
                    children: [
                      Text("LOW",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 3,
                      ),
                      Text('${prdertot.ld}/${prdertot.ln+prdertot.ld}'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      )  ,
    );
  }

}