import 'package:cloud_firestore/cloud_firestore.dart';
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
    String codeCorrectionQuestion = "";
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('exams')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Container();
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      codeCorrectionQuestion = snapshot.data!.docs[i].get('codeCorrectionQuestionWrong');
                    }
                    return ListTile(
                      leading: Icon(Icons.question_mark_outlined),
                      title: Text(codeCorrectionQuestion),
                      tileColor: Colors.redAccent,
                    );
                  }),
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
