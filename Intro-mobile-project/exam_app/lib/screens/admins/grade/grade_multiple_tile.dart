import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';

class GradeMultipleTile extends StatelessWidget {
  const GradeMultipleTile({Key? key, required this.multipleChoiseAnswer, required this.student}) : super(key: key);
  final String multipleChoiseAnswer;
  final String student;

  @override
  Widget build(BuildContext context) {
    String multipleChoiseQuestion = "";
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('exams')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Container();
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      multipleChoiseQuestion = snapshot.data!.docs[i].get('multipleChoiseQuestion');
                    }
                    return ListTile(
                      leading: Icon(Icons.question_mark_outlined),
                      title: Text(multipleChoiseQuestion),
                      tileColor: Colors.redAccent,
                    );
                  }),
              ListTile(
                leading: Icon(Icons.check),
                title: Text(multipleChoiseAnswer.toString()),
                tileColor: Colors.green,
              ),
            ],
          ),
        ));
  }
}