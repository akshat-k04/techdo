import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/models/todomodel.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';
import 'package:techdo/screens/afterauth/HomeScreen.dart';
import 'package:techdo/screens/customWidget/inputField.dart';
import 'package:techdo/screens/customWidget/toast.dart';
import 'package:uuid/uuid.dart';

class updatetodo extends StatelessWidget{
  todomdl tempe ;

  updatetodo({super.key,required this.tempe});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _head = TextEditingController(text: tempe.heading);
    final TextEditingController _details = TextEditingController(text: tempe.details);

    int num= (tempe.priority=='low')?0: (tempe.priority=='high')?2 : 1 ;

    todoprovider prder = Provider.of<todoprovider>(context,listen: false);
    authprovider authprder = Provider.of<authprovider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(_head==""||_details==""){
            showToast(context, "Input field can\'t be empty");
          }
          else{
            todomdl tod = todomdl(
                date: tempe.date ,
                email: authprder.email ,
                heading: _head.text ,
                details: _details.text,
                doneornot: tempe.doneornot ,
                priority: (num==0)?"low":(num==1)?"modarate":"high" ,
                unqid:tempe.unqid
            ) ;
            await prder.update(tod, authprder.hashmail) ;
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home())) ;
          }
        },
        backgroundColor: Color(0xFF9BA4B5),
        child: Icon(CupertinoIcons.create_solid),
      ),
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
                    Expanded(child: WriteHere(hint: 'Heading', controller: _head, readonly:false ,)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius:  BorderRadius.all(Radius.circular(30))
                        ),
                        child: TextField(
                            controller:  _details,
                            style: const TextStyle(
                                fontFamily: 'ubantu'
                            ),
                            decoration: const InputDecoration(
                              hintText: "details",
                              border: InputBorder.none,

                            )
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Color(0xFF9BA4B5)),
                      ),
                      onPressed: (){
                        num=0 ;
                      }, child: const Text("low")),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Color(0xFF9BA4B5)),
                      ),
                      onPressed: (){
                        num=1 ;
                      }, child: const Text("modarate")),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Color(0xFF9BA4B5)),
                      ),
                      onPressed: (){
                        num=2 ;
                      }, child: const Text("high")),
                ],
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