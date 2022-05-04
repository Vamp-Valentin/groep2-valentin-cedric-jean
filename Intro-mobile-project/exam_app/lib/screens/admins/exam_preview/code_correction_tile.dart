import 'package:exam_app/models/my_exam.dart';
import 'package:flutter/material.dart';

class CodeCorrectionTile extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  CodeCorrectionTile({this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.flaky_outlined),
                title: Text("Code correction"),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.dnd_forwardslash_rounded),
                title: Text("Wrong code: " + exam!.codeCorrectionQuestionWrong.toString()),
                tileColor: Colors.redAccent,

              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text("Correct code:" + exam!.codeCorrectionQuestionCorrect.toString()),
                tileColor: Colors.green,
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
