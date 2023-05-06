import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WriteHere extends StatefulWidget{
  String hint ;
  bool readonly  ;
  TextEditingController controller ;
  WriteHere({super.key,required this.hint,required this.controller, required this.readonly});
  @override
  State<StatefulWidget> createState() {
    return writestate() ;
  }

}

class writestate extends State<WriteHere>{
  bool showpass = false ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white54,
          borderRadius:  BorderRadius.all(Radius.circular(30))
      ),
      child: TextFormField(
        controller:  widget.controller,
        readOnly:  widget.readonly,
        obscureText: (showpass || (widget.hint!="Password"&&widget.hint!="Confirm Password"))?false:true,
        style: TextStyle(
          fontFamily: 'ubantu'
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: (widget.hint=="Password"||widget.hint=="Confirm Password")?IconButton(
            onPressed: () {
              setState(() {
                showpass=!showpass ;
              });
            },
            icon: showpass?const Icon(
              CupertinoIcons.eye_fill,
              color: Color(0xFF1E1E1E),
            ):const Icon(
              CupertinoIcons.eye_slash,
              color: Color(0xFF1E1E1E),

            ),
          ):null
        ),
      ),
    ) ;
  }

}