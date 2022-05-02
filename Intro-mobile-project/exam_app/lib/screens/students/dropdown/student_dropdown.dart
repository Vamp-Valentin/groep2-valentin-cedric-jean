import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   User? user = FirebaseAuth.instance.currentUser;
//   MyUser loggedInUser = MyUser();
//   MyExam exam = MyExam();

//   @override
//   void initState() {
//     super.initState();
//     if(user?.uid != null){
//     FirebaseFirestore.instance.collection("exams").doc(user!.uid).get().then(
//         (value) => {
//               this.exam = MyExam.fromMap(value.data()),
//               setState(() {})
//             });
//   }}
//   String? dropdownValue = "";

//   @override
//   Widget build(BuildContext context) {
  //   final students = exam.students;
  //   final splitstudents = students?.split(';');
  //   List splitList = [];
  //   for (int i = 0; i < students.toString().length; i++){
  //     splitList.add(splitstudents?[i]);
  //   }

  //   return DropdownButton<String>(
  //     value: dropdownValue,
  //     icon: const Icon(Icons.arrow_downward),
  //     elevation: 16,
  //     style: const TextStyle(color: Colors.red),
  //     underline: Container(
  //       height: 2,
  //       color: Colors.red,
  //     ),
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         dropdownValue = newValue!;
  //       });
  //     },
  //     items: <String>['One', 'Two', 'Free', 'Four']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //   );
  // }
//}