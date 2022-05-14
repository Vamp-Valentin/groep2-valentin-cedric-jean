class MyStudent {
  final String? sNumber;
  final String? question;
  final String? answer;
  final int? timer;
  final String? latitude;
  final String? longlatitude;

  MyStudent({this.sNumber, this.question, this.answer, this.timer, this.latitude, this.longlatitude});

    //get data from database
  factory MyStudent.fromMap(map){
    return MyStudent(
      sNumber: map['sNumber'],
      question: map['email'],
      answer: map['firstName'],
      timer: map['timer'],
      latitude: map['latitude'],
      longlatitude: map['longlatitude'],
    );
  }
}
