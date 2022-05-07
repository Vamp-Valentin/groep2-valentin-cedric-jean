import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference examCollection =
      FirebaseFirestore.instance.collection('exams');

  //update all
  Future updateUserData(
      String examName,
      String openQuestion,
      String codeCorrectionQuestionWrong,
      String codeCorrectionQuestionCorrect,
      String multipleChoiseQuestion,
      String multipleChoisePossibilities,
      String multipleChoiseAnswer,
      String students,
      int timer) async {
    return await examCollection.doc(uid).set({
      'uid': uid,
      'examName': examName,
      'openQuestion': openQuestion,
      'codeCorrectionQuestionWrong': codeCorrectionQuestionWrong,
      'codeCorrectionQuestionCorrect': codeCorrectionQuestionCorrect,
      'multipleChoiseQuestion': multipleChoiseQuestion,
      'multipleChoisePossibilities': multipleChoisePossibilities,
      'multipleChoiseAnswer': multipleChoiseAnswer,
      'students': students,
      'timer': timer
    });
  }

  //update open question
  Future updateOpenQuestion(String openQuestion) async {
    return await examCollection.doc(uid).update({
      'openQuestion': openQuestion,
    });
  }

  Future update(int timer) async {
    return await examCollection.doc(uid).update({
      'timer': timer,
    });
  }

  //update open question
  Future deleteOpenQuestion() async {
    return await examCollection.doc(uid).update({
      'openQuestion': "",
    });
  }

  //update code correction question
  Future updateCodeCorrectionQuestion(
    String codeCorrectionQuestionWrong,
    String codeCorrectionQuestionCorrect,
  ) async {
    return await examCollection.doc(uid).update({
      'codeCorrectionQuestionWrong': codeCorrectionQuestionWrong,
      'codeCorrectionQuestionCorrect': codeCorrectionQuestionCorrect,
    });
  }

  //update code correction question
  Future updateMultipleChoiseQuestion(
    String multipleChoiseQuestion,
    String multipleChoisePossibilities,
    String multipleChoiseAnswer,
  ) async {
    return await examCollection.doc(uid).update({
      'multipleChoiseQuestion': multipleChoiseQuestion,
      'multipleChoisePossibilities': multipleChoisePossibilities,
      'multipleChoiseAnswer': multipleChoiseAnswer,
    });
  }

  //update students
  Future updateStudents(String students) async {
    return await examCollection.doc(uid).update({
      'students': students,
    });
  }

  //exam list from snapshot
  List<MyExam> _examListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MyExam(
        uid: doc.data().toString().contains('uid') ? doc.get('uid') : '',
        examName: doc.data().toString().contains('examName')
            ? doc.get('examName')
            : '',
        openQuestion: doc.data().toString().contains('openQuestion')
            ? doc.get('openQuestion')
            : '',
        codeCorrectionQuestionWrong: doc.data().toString().contains('codeCorrectionQuestionWrong')
            ? doc.get('codeCorrectionQuestionWrong')
            : '',
        codeCorrectionQuestionCorrect: doc.data().toString().contains('codeCorrectionQuestionCorrect')
            ? doc.get('codeCorrectionQuestionCorrect')
            : '',
        multipleChoiseQuestion: doc.data().toString().contains('multipleChoiseQuestion')
            ? doc.get('multipleChoiseQuestion')
            : '',
        multipleChoisePossibilities: doc.data().toString().contains('multipleChoisePossibilities')
            ? doc.get('multipleChoisePossibilities')
            : '',
        multipleChoiseAnswer: doc.data().toString().contains('multipleChoiseAnswer')
            ? doc.get('multipleChoiseAnswer')
            : '',
        students: doc.data().toString().contains('students')
            ? doc.get('students')
            : '',
      );
    }).toList();
  }

  //get exam stream
  Stream<List<MyExam>> get exams {
    return examCollection.snapshots().map(_examListFromSnapshot);
  }
}
