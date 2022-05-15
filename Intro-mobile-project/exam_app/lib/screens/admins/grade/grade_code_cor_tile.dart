import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeCodeCorrectionTile extends StatelessWidget {
  const GradeCodeCorrectionTile(
      {Key? key,
      required this.codeCorrectionAnswer,
      required this.student,})
      : super(key: key);
  final String codeCorrectionAnswer;
  final String student;

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
                title: Text("code correction question"),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text(codeCorrectionAnswer.toString()),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(codeCorrectionAnswer.toString()),
                tileColor: Colors.green,
              ),
            ],
          ),
        ));
  }
}
