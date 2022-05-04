import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/exam_preview/exam_preview.dart';
import 'package:exam_app/screens/admins/home/default_screen.dart';
import 'package:exam_app/screens/admins/results/student_list.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_app/screens/admins/home/exam_list.dart';

class Exam extends StatelessWidget {
  Exam({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MyExam>?>.value(
      initialData: [],
      value: DatabaseService().exams,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAdmin())),
          ),
            backgroundColor: Colors.red,
            title: Text("Preview"),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: const ExamPreview()
          ),
    );
  }
}