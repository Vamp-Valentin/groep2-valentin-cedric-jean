import 'package:exam_app/models/my_exam.dart';
import 'package:flutter/material.dart';

class ExamTile extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  ExamTile({this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            child: Icon(Icons.domain_verification_outlined),
          ),
          title: Text(exam!.examName.toString()),
          subtitle: Text(exam!.students.toString()),
        ),
      ),
    );
  }
}