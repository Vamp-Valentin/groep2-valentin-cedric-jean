class MyStudent {
  final String? sNumber;
  final String? question;
  final String? answer;
  final int? timer;

  MyStudent({this.sNumber, this.question, this.answer, this.timer});

    //get data from database
  factory MyStudent.fromMap(map){
    return MyStudent(
      sNumber: map['sNumber'],
      question: map['email'],
      answer: map['firstName'],
      timer: map['lastName'],
    );
  }
}
