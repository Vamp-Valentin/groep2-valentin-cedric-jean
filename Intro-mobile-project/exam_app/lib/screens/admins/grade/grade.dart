import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/admins/grade/grade_code_cor_tile.dart';
import 'package:exam_app/screens/admins/grade/grade_multiple_tile.dart';
import 'package:exam_app/screens/admins/grade/grade_open_tile.dart';
import 'package:exam_app/screens/admins/grade/grading.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/location/location.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeWidget extends StatelessWidget {
  GradeWidget({
    required this.student,
    Key? key,
  }) : super(key: key);

  final String student;

  @override
  Widget build(BuildContext context) {
    String codeCorrectionQuestionAnswer = "";
    String multipleChoiseAnswerStudent = "";
    String openQuestionAnswer = "";

    String multipleChoiseAnswer = "";
    String codeCorrectionQuestionCorrect = "";

    final editResult = new TextEditingController();

    Grading grading = Grading();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Results())),
          ),
          backgroundColor: Colors.red,
          title: Text(student),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('students')
                .orderBy('sNumber')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Container();
              List students = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                String stu = snapshot.data!.docs[i].get('sNumber');
                if (stu == student) {
                  codeCorrectionQuestionAnswer =
                      snapshot.data!.docs[i].get('codeCorrectionAnswer');
                  multipleChoiseAnswerStudent =
                      snapshot.data!.docs[i].get('multipleChoiseAnswer');
                  openQuestionAnswer = snapshot.data!.docs[i].get('openAnswer');
                }
              }
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GradeOpenTile(
                        openQuestionAnswer: openQuestionAnswer,
                        student: student, editResult: editResult,
                      ),
                      GradeMultipleTile(
                        multipleChoiseAnswer: multipleChoiseAnswerStudent,
                        student: student,
                      ),
                      GradeCodeCorrectionTile(
                        codeCorrectioAnswer: codeCorrectionQuestionAnswer,
                        student: student,
                        editResult: editResult,
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
