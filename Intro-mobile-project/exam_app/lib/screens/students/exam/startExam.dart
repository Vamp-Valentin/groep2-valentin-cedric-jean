import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/students/exam/FinishedExam.dart';
import 'package:exam_app/screens/students/exam/timer.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/variables.dart';

class CompleteExam extends StatefulWidget {
  const CompleteExam({Key? key, required this.student}) : super(key: key);
  final String student;

  @override
  State<CompleteExam> createState() => _CompleteExamState();
}

class _CompleteExamState extends State<CompleteExam> {
  int selectedRadio = 0;
  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int value){
    setState(() {
      selectedRadio = value;
    });
  }

  Widget build(BuildContext context) {

    List splitMultiChoicePoss(String? multipleChoisePossibilities){
      List splitList = [];
      final splitMultiChoicePoss = multipleChoisePossibilities?.split(';');
      if(splitMultiChoicePoss != null){
        for(int i = 0; i < splitMultiChoicePoss.length; i++){
          splitList.add(splitMultiChoicePoss[i]);
        }
      }
        return splitList;
      }
      List splitList = splitMultiChoicePoss(multipleChoisePossibilities);

    final TextEditingController answerOneFieldController =
        new TextEditingController();
    final TextEditingController answerTwoFieldController =
        new TextEditingController();
    final TextEditingController answerThreeFieldController =
        new TextEditingController();

    final answerOneField = TextFormField(
      autofocus: false,
      controller: answerOneFieldController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final answerTwoField = TextFormField(
      autofocus: false,
      controller: answerTwoFieldController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //save button
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          DatabaseService(uid: widget.student).updateAnswers(
              answerTwoFieldController.text,
              answerOneFieldController.text,
              splitList[selectedRadio-1]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => FinishedExam(student: widget.student,)));
        },
        child: const Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //time button
    final timeButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TimerWidget()));
        },
        child: const Text(
          "check time",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      //appBar: AppBar(title: Text("exam"),actions: [timeButton],),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('exams').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return Container();
                    codeCorrectionQuestionWrong =
                        snapshot.data!.docs[0].get('codeCorrectionQuestionWrong');
                    multipleChoiseQuestion =
                        snapshot.data!.docs[0].get('multipleChoiseQuestion');
                    multipleChoisePossibilities =
                        snapshot.data!.docs[0].get('multipleChoisePossibilities');
                    openQuestion = snapshot.data!.docs[0].get('openQuestion');
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          Text(
                            'Q1 Code Correction: ' '$codeCorrectionQuestionWrong',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 19),
                          ),
                          const SizedBox(height: 45),
                          answerOneField,
                          const SizedBox(height: 40),
                          Text(
                            'Q2 Open Question: ' '$openQuestion',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 19),
                          ),
                          const SizedBox(height: 45),
                          answerTwoField,
                          const SizedBox(height: 40),
                          const Text('Q3 Multiple choice question:',
                            style: TextStyle(
                              fontSize: 19
                            )
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: selectedRadio,
                                    onChanged: (value){
                                      setSelectedRadio(value as int);
                                      print(selectedRadio);
                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Text(
                                      splitList[0]
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: selectedRadio,
                                    onChanged: (value){
                                      setSelectedRadio(value as int);
                                      print(selectedRadio);
                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Text(
                                      splitList[1]
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue: selectedRadio,
                                    onChanged: (value){
                                      setSelectedRadio(value as int);
                                      print(selectedRadio);
                                    },
                                  ),
                                  const SizedBox(width: 10.0,),
                                  Text(
                                      splitList[2]
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomSheet: saveButton,
    );
  }

  String splitAnswer(String answer) {
    return answer.replaceAll(";", "\n\n");
  }
}
