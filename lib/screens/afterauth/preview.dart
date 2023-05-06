import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class preview extends StatelessWidget{
  String head ;
  String details ;

  preview({super.key , required this.details , required this.head});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.transparent,

      body: Container(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(),
              SizedBox(
                height: 150,
              ),
              Container(
                height: 120,
                // width:400 ,
                margin: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0x998294C4),
                    // color: Color(0X99394867),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Row(
                  children:  [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius:  BorderRadius.all(Radius.circular(30))
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child: Text(
                              head,
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                  fontFamily: 'ubantu',
                                   fontSize: 20,fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),


              Container(
                height: 400,
                // width:400 ,
                margin: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0x998294C4),
                    // color: Color(0X99394867),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Row(
                  children:  [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 350,
                        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                        decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius:  BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text( details,

                            style: TextStyle(
                              fontSize: 20,
                                fontFamily: 'ubantu'
                            ),

                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 98,
              )
            ],
          ),
        ),
      ),
    );
  }

}