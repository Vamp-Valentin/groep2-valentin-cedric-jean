import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  Timer({this.exam});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

 
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.text_snippet),
                title: Text("Open question"),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text(exam!.openQuestion.toString()),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text("..."),
                tileColor: Colors.green,
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: const Icon(Icons.delete),
                    onPressed: () {
                      DatabaseService(uid: user.uid).deleteOpenQuestion();
            
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
