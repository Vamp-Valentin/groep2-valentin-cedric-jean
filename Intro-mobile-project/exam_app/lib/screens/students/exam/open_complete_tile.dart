import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenCompleteTile extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  OpenCompleteTile({this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.text_snippet),
                title: Text(exam!.openQuestion.toString()),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text("..."),
                tileColor: Colors.green,
              ),
            ],
          ),
        ));
}
}