import 'dart:ffi';

class MyExam {
  final String? uid;
  final String? examName;
  final String? openQuestion;
  final String? codeCorrectionQuestionWrong;
  final String? codeCorrectionQuestionCorrect;
  final String? students;

  MyExam(
      {this.uid,
      this.examName,
      this.openQuestion,
      this.codeCorrectionQuestionWrong,
      this.codeCorrectionQuestionCorrect,
      this.students
      });
}
