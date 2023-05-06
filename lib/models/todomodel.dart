class todomdl {
  String? email ;
  String? hashmail ;
  String? date ;
  String ? heading ;
  String ? details;
  String ? priority ;
  String ? doneornot ;
  String ? unqid ;
  todomdl({this.date,this.email,this.heading,this.details,this.doneornot,this.priority,this.unqid, this.hashmail}) ;

 Map<String,dynamic> getmap(){
    return {
      "email": email,
      "hashmail": hashmail
    };
  }
  Map<String,dynamic> todomap(){
    return {
      "email": email,
      "hashmail": hashmail,
      "date":date ,
      "heading":heading,
      "details":details ,
      "priority":priority,
      "doneornot":doneornot ,
      "unqid":unqid ,
    };
  }

}