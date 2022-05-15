class MyStudent {
  final String? sNumber;
  final String? question;
  //final String? answer;
  final String? openAnswer;
  final String? codeCorrectionAnswer;
  final String? multipleChoiseAnswer;
  final int? timer;
  final String? latitude;
  final String? longlatitude;
  final int? result;
  final String? address;

  MyStudent({this.sNumber, this.question, this.openAnswer,this.codeCorrectionAnswer, this.multipleChoiseAnswer, this.timer, this.latitude, this.longlatitude, this.result, this.address});

  //get data from database
  factory MyStudent.fromMap(map) {
    return MyStudent(
      sNumber: map['sNumber'],
      question: map['question'],
      openAnswer: map['openAnswer'],
      codeCorrectionAnswer: map['codeCorrectionAnswer'],
      multipleChoiseAnswer: map['multipleChoiseAnswer'],
      timer: map['timer'],
      latitude: map['latitude'],
      longlatitude: map['longlatitude'],
      result: map['result'],
      address: map['address'],
    );
  }
}
