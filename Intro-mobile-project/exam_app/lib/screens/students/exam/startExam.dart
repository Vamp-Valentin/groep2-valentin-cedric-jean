import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/students/exam/FinishedExam.dart';
import 'package:exam_app/screens/students/exam/timer.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class CompleteExam extends StatelessWidget {
  const CompleteExam({Key? key, required this.student}) : super(key: key);
  final String student;

  @override

  
  Widget build(BuildContext context) {
    String codeCorrectionQuestionWrong = "";
    String multipleChoiseQuestion = "";
    String multipleChoisePossibilities = "";
    String openQuestion = "";

    final TextEditingController answerOneFieldController =
        new TextEditingController();
    final TextEditingController answerTwoFieldController =
        new TextEditingController();
    final TextEditingController answerThreeFieldController =
        new TextEditingController();

    final answerOneField = TextFormField(
      autofocus: false,
      controller: answerOneFieldController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final answerTwoField = TextFormField(
      autofocus: false,
      controller: answerTwoFieldController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final answerThreeField = TextFormField(
      autofocus: false,
      controller: answerThreeFieldController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          DatabaseService(uid: student).updateAnswers(
              answerTwoFieldController.text,
              answerOneFieldController.text,
              answerThreeFieldController.text);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FinishedExam(student: student,)));
        },
        child: const Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //time button
    final timeButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TimerWidget()));
        },
        child: const Text(
          "check time",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      //appBar: AppBar(title: Text("exam"),actions: [timeButton],),
      body: SingleChildScrollView(
        child: Center(
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
                    multipleChoisePossibilities =
                        snapshot.data!.docs[0].get('multipleChoisePossibilities');
                    openQuestion = snapshot.data!.docs[0].get('openQuestion');
                    return Column(
                      children: [
                        Text(
                          'Q1 Code Correction: ' '$codeCorrectionQuestionWrong',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        const SizedBox(height: 45),
                        answerOneField,
                        Divider(color: Colors.black),
                        const SizedBox(height: 40),
                        Text(
                          'Q2 Open Question: ' '$openQuestion',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        const SizedBox(height: 45),
                        answerTwoField,
                        Divider(color: Colors.black),
                        const SizedBox(height: 40),
                        Text(
                          'Q3 Multiple choice question: '
                          '$multipleChoiseQuestion\n\n ${splitAnswer(multipleChoisePossibilities)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        const SizedBox(height: 45),
                        answerThreeField,
                        Divider(color: Colors.black),
                        const SizedBox(height: 45),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomSheet: saveButton,
    );
  }

  String splitAnswer(String answer) {
    return answer.replaceAll(";", "\n\n");
  }
}
