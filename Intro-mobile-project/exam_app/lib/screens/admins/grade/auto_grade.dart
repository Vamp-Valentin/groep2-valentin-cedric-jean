import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/admins/grade/grading.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class AutoGrade extends StatelessWidget {
  const AutoGrade({Key? key, required this.codeCorrectionStudentAnswer, required this.multipleChoiseStudentAnswer, required this.student, required this.score}) : super(key: key);
  final String codeCorrectionStudentAnswer;
  final String multipleChoiseStudentAnswer;
  final String student;
  final int score;

  @override
  Widget build(BuildContext context) {
    Grading grading = Grading();
    String codeCorrectionAnswer = "";
    String multiplechoiseAnswer = "";
    int total = 0;
    return MaterialApp(
      home: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('exams')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Container();
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  codeCorrectionAnswer = snapshot.data!.docs[i].get('codeCorrectionQuestionCorrect');
                  multiplechoiseAnswer = snapshot.data!.docs[i].get('multipleChoiseAnswer');
              }
              total += grading.gradeQuestion(codeCorrectionAnswer, codeCorrectionStudentAnswer, score);
              total += grading.gradeQuestion(multiplechoiseAnswer, multipleChoiseStudentAnswer, score);
              DatabaseService(uid: student).updateGrading(total, score);
              return Container();
            }),
      ),
    );
  }
}