import 'dart:ffi';

class MyExam {
  final String? uid;
  final String? examName;
  final String? openQuestion;
  final String? codeCorrectionQuestionWrong;
  final String? codeCorrectionQuestionCorrect;
  final String? multipleChoiseQuestion;
  final String? multipleChoisePossibilities;
  final String? multipleChoiseAnswer;
  final String? students;
  final num? timer;

  MyExam(
      {this.uid,
      this.examName,
      this.openQuestion,
      this.codeCorrectionQuestionWrong,
      this.codeCorrectionQuestionCorrect,
      this.multipleChoiseQuestion,
      this.multipleChoisePossibilities,
      this.multipleChoiseAnswer,
      this.students,
      this.timer
      });
}
