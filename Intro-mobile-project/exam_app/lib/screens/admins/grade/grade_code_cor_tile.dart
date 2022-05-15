import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeCodeCorrectionTile extends StatelessWidget {
  const GradeCodeCorrectionTile(
      {Key? key,
      required this.codeCorrectioAnswer,
      required this.student,
      required this.editResult})
      : super(key: key);
  final String codeCorrectioAnswer;
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
        DatabaseService(uid: student).updateGrading(double.parse(value));
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //hintText: "Minutes",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

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
                title: Text(codeCorrectioAnswer.toString()),
                tileColor: Colors.redAccent,
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(codeCorrectioAnswer.toString()),
                tileColor: Colors.green,
              ),
              ListTile(
                title: gradeField,
              ),
            ],
          ),
        ));
  }
}
