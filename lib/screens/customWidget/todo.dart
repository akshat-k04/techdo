import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techdo/models/todomodel.dart';
import 'package:techdo/providers/authprovider.dart';
import 'package:techdo/providers/todoprovider.dart';

class TodoTile extends StatefulWidget{
  String heading ;
  String priority ;
  todomdl fog ;
  TodoTile({super.key, required this.priority, required this.heading,required this.fog});
  @override
  State<StatefulWidget> createState() {
    return TileState() ;
  }

}

class TileState extends State<TodoTile>{
  @override
  Widget build(BuildContext context) {
    todoprovider prder = Provider.of<todoprovider>(context,listen: false);
    authprovider authprder = Provider.of<authprovider>(context,listen: false);
    return Container(
      height: 80,
      // width:100 ,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: (widget.fog.doneornot=='not')?Color(0x998294C4):Color(0XFF212A3E),
        // color: Color(0X99394867),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ColoredBox(
              color: (widget.priority=="high")?Colors.redAccent:(widget.priority=="modarate")?Colors.yellow:Colors.green,
            child: SizedBox(
              height: 1,
              width: 200,
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                        widget.heading,
                      style: const TextStyle(
                        fontFamily: "Patrick",
                        fontSize: 25
                      ),
                    ),
                  ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: (){
                    widget.fog.doneornot = (widget.fog.doneornot=='not')?"done":"not" ;
                    prder.update(widget.fog, authprder.hashmail) ;
                  },
                  icon:Icon((widget.fog.doneornot=='not')?Icons.done_outline_rounded:Icons.incomplete_circle_rounded)
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
  }

}