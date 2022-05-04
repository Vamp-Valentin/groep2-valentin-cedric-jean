import 'package:exam_app/models/my_exam.dart';
import 'package:flutter/material.dart';

class MultipleChoiceTile extends StatelessWidget {
  //const ExamTile({Key? key}) : super(key: key);
  final MyExam? exam;
  MultipleChoiceTile({this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.format_list_bulleted_rounded),
                title: Text("Multiple Choise"),
                tileColor: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: Text(exam!.multipleChoiseQuestion.toString()),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(checkAnswer(splitAnswer(exam!.multipleChoisePossibilities.toString()),exam!.multipleChoiseAnswer.toString())),
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
  String splitAnswer(String answer) {
    return answer.replaceAll(";", "\n\n");
  }
  String checkAnswer(String pos, String answ){
    String res ="";
    res = pos.replaceAll(answ, "--> " + answ.toUpperCase() + " <--");
    return res;
  }

}
