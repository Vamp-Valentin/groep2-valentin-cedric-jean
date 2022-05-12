import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/students/exam/timer.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentDropdown extends StatefulWidget {
  StudentDropdown({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _StudentDropdownState createState() => _StudentDropdownState();
}

class _StudentDropdownState extends State<StudentDropdown> {
  var students, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;
  // User? user = FirebaseAuth.instance.currentUser;
  // MyUser loggedInUser = MyUser();
  // MyExam exam = MyExam();


  @override
  Widget build(BuildContext context) {
    debugPrint('students: $students');
    List splitList = [];
    List<DropdownMenuItem<String>> dropdownItems = [];
    String student = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(student),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('exams')
                    .orderBy('examName')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Safety check to ensure that snapshot contains data
                  // without this safety check, StreamBuilder dirty state warnings will be thrown
                  if (!snapshot.hasData) return Container();

                  // Set this value for default,
                  // setDefault will change if an item was selected
                  // First item from the List will be displayed
                  if (setDefaultMake) {
                    students = snapshot.data!.docs[0].get('students');
                    debugPrint('setDefault make: $students');
                    final splitstudents = students?.split(';');
                    if (splitstudents != null) {
                      for (int i = 0; i < splitstudents.length; i++) {
                        splitList.add(splitstudents?[i]);
                        debugPrint(splitList[i]);
                      }
                      student = splitList[0];
                    }
                  }
                  if (dropdownItems.isEmpty) {
                    for (var item in splitList) {
                      String stu = item;
                      var newItem = DropdownMenuItem(
                        child: Text(stu),
                        value: stu,
                      );
                      dropdownItems.add(newItem);
                    }
                  }

                  return DropdownButton(
                    isExpanded: false,
                    value: student,
                    items: dropdownItems,
                    onChanged: (value) {
                                Navigator.of(context)
                         .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                      debugPrint('selected onchange: $value');
                      setState(
                        () {
                          debugPrint('make selected: $value');
                          // Selected value will be stored
                          student = value.toString();
                          // Default dropdown value won't be displayed anymore
                          setDefaultMake = false;
                          // Set makeModel to true to display first car from list
                          setDefaultMakeModel = true;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}