import 'package:exam_app/screens/students/home/home.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/variables.dart';


class FinishedExam extends StatelessWidget {
  const FinishedExam({Key? key, required this.student}) : super(key: key);
  final String student;

@override
  Widget build(BuildContext context) {
    final leaveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 350,
        onPressed: () {
          counter = 0;
          DatabaseService(uid: student).updateTimesLeft(counter);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeStudent(student: student)));
        },
        child: const Text(
          "go to Home page",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Flexible(
                  flex: 1,
                  child: Container(
                    child: const Text("Exam ended succesfully!", style: TextStyle(
                      fontSize: 20
                    ),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Flexible(
                flex: 4,
                child: Container(
                  child: Text("Left exam: " "$counter times", style: const TextStyle(
                    fontSize: 20,
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Flexible(
                flex: 4,
                child: Container(
                  child: leaveButton,
                ),
              ),
            )
            /*const Text("Exam ended Succesfully!",
              style: TextStyle(
                fontSize: 19
              ),
              ),
              Text("Left exam:" "$counter times",
                style: const TextStyle(
                  fontSize: 19
                ),
              ),
              leaveButton*/
          ],
        ),
      ),
    ));
}
}
