import 'dart:ffi';

class MyExam {
  String? uid;
  String? examName;
  List<String>? openQuestion;
  String? students;

  MyExam({this.uid, this.examName, this.openQuestion, this.students});

  //get data from database
  factory MyExam.fromMap(map){
    return MyExam(
      uid: map['uid'],
      examName: map['examName'],
      openQuestion: map['openQuestion'],
      students: map['students'],
    );
  }

  //send data to database
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'examName': examName,
      'openQuestion': openQuestion,
      'students': students,
    };
  }
}