import 'dart:ffi';

class MyExam {
  String? uid;
  String? examName;
  String? openQuestion;

  MyExam({this.uid, this.examName, this.openQuestion});

  //get data from database
  factory MyExam.fromMap(map){
    return MyExam(
      uid: map['uid'],
      examName: map['examName'],
      openQuestion: map['openQuestion'],
    );
  }

  //send data to database
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'examName': examName,
      'openQuestion': openQuestion,
    };
  }
}