import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeMultipleTile extends StatelessWidget {
  const GradeMultipleTile({Key? key, required this.multipleChoiseAnswer, required this.student}) : super(key: key);
  final String multipleChoiseAnswer;
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
                title: Text("Multiple choise question"),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text(multipleChoiseAnswer.toString()),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(multipleChoiseAnswer.toString()),
                tileColor: Colors.green,
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      DatabaseService(uid: student).updateGrading(10.0);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}