import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/models/todomodel.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';
import 'package:techdo/screens/afterauth/preview.dart';
import 'package:techdo/screens/afterauth/update.dart';
import 'package:techdo/screens/customWidget/todo.dart';

class col extends StatelessWidget{
  List<todomdl> temper;
  String priority ;
  col({super.key,required this.temper,required this.priority});

  @override
  Widget build(BuildContext context) {
    todoprovider prdertot = Provider.of<todoprovider>(context,listen: false);
    authprovider prder = Provider.of<authprovider>(context,listen: false);

    return ListView.builder(

        physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: temper.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: ()async {
          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>preview(details: temper[index].details!, head: temper[index].heading!,)));
          //preview
        },
        onDoubleTap: (){
          // Navigator.of(context).push(createRoute("edit",index));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>updatetodo(tempe: temper[index],)));

          //edit

        },
        onLongPress: (){
          prdertot.delete( temper[index], prder.hashmail);
          //to delete
        },
        child: TodoTile(priority: priority, heading: temper[index].heading!, fog: temper[index],)
      );
    }
    ) ;
  }

}