import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:flutter/material.dart';

class CompleteExam extends StatefulWidget {
  CompleteExam({Key? key, this.sNumber, this.student}) : super(key: key);

  final String? sNumber;
  final MyStudent? student;
  final String codeCorrectionQuestionCorrect = "";
  @override
  State<CompleteExam> createState() => _CompleteExamState();
}

class _CompleteExamState extends State<CompleteExam> {
  @override
  Widget build(BuildContext context) {
    String codeCorrectionQuestionWrong = "";
    String multipleChoiseQuestion = "";
    String openQuestion = "";
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('exams').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();
                  codeCorrectionQuestionWrong =
                      snapshot.data!.docs[0].get('codeCorrectionQuestionWrong');
                  multipleChoiseQuestion =
                      snapshot.data!.docs[0].get('multipleChoiseQuestion');
                  openQuestion = snapshot.data!.docs[0].get('openQuestion');
                  return Text(
                    '$codeCorrectionQuestionWrong',
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 25),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
