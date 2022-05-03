import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/screens/admins/students/add_students.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_app/screens/admins/home/exam_list.dart';

class HomeAdmin extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MyExam>?>.value(
      initialData: [],
      value: DatabaseService().exams,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text("Exams"),
            centerTitle: true,
            actions: <Widget>[
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () async{
                    await _auth.signOut();
                  })
            ],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
                child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                    //key: _formkey,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    ExamList(),
                    SizedBox(height: 25),
                  ],
                )),
              ),
            )),
          )
          ),
    );
  }
}