import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/students/exam/timer.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:exam_app/screens/students/location/location.dart';
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
                    .collection('students')
                    .orderBy('sNumber')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();
                  if (setDefaultMake) {
                    List students = [];
                    for(int i = 0;i< snapshot.data!.docs.length;i++){
                      students.add(snapshot.data!.docs[i].get('sNumber'));
                    }
                    debugPrint('setDefault make: $students');
                    if (students != null) {
                      for (int i = 0; i < students.length; i++) {
                        splitList.add(students?[i]);
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
                        //  .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                        .pushReplacement(MaterialPageRoute(builder: (context) => LocationWidget(student: student,)));
                      debugPrint('selected onchange: $value');
                      setState(
                        () {
                          debugPrint('make selected: $value');
                          student = value.toString();
                          setDefaultMake = false;
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