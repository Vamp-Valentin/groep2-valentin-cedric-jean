import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeOpenTile extends StatelessWidget {
  const GradeOpenTile(
      {Key? key,
      required this.openQuestionAnswer,
      required this.student,
      required this.editResult})
      : super(key: key);
  final String openQuestionAnswer;
  final String student;
  final TextEditingController editResult;

  @override
  Widget build(BuildContext context) {

    final gradeField = TextFormField(
      autofocus: false,
      controller: editResult,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        editResult.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 3,
        onPressed: () async {
          DatabaseService(uid: student).updateGrading(int.parse(editResult.text));
        },
        child: Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );


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
                title: Text("Hoe gaat het?"),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(openQuestionAnswer.toString()),
                tileColor: Colors.green,
              ),
              ListTile(
                title: gradeField,
                trailing: saveButton,
              ),
            ],
          ),
        ));
  }
}
