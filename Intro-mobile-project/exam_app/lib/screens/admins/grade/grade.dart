import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/location/location.dart';
import 'package:flutter/material.dart';

// class GradeWidget extends StatefulWidget {
//   GradeWidget({Key? key, required this.student}) : super(key: key);
//   final String? student;

//   @override
//   State<GradeWidget> createState() => _GradeWidgetState();
// }

// class _GradeWidgetState extends State<GradeWidget> {
//   var students, carMakeModel;
//   var setDefaultMake = true, setDefaultMakeModel = true;
//   LocationFunc loc = LocationFunc();
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelStyle: const TextStyle(fontSize: 20),
//         labelText: student,
//       ),
//       obscureText: (this.texto == "Password") ? true : false,
//       controller: usuario,
//     );
//     // debugPrint('students: $students');
//     // List splitList = [];
//     // List<DropdownMenuItem<String>> dropdownItems = [];
//     // String student = "";
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text(student),
//     //   ),
//     //   body: Column(
//     //     children: [
//     //       Expanded(
//     //         flex: 1,
//     //         child: Center(
//     //           child: StreamBuilder<QuerySnapshot>(
//     //             stream: FirebaseFirestore.instance
//     //                 .collection('students')
//     //                 .orderBy('sNumber')
//     //                 .snapshots(),
//     //             builder: (BuildContext context,
//     //                 AsyncSnapshot<QuerySnapshot> snapshot) {
//     //               if (!snapshot.hasData) return Container();
//     //               if (setDefaultMake) {
//     //                 List students = [];
//     //                 for(int i = 0;i< snapshot.data!.docs.length;i++){
//     //                   students.add(snapshot.data!.docs[i].get('sNumber'));
//     //                 }
//     //                 debugPrint('setDefault make: $students');
//     //                 if (students.isNotEmpty) {
//     //                   for (int i = 0; i < students.length; i++) {
//     //                     splitList.add(students[i]);
//     //                     debugPrint(splitList[i]);
//     //                   }
//     //                   student = splitList[0];
//     //                 }
//     //               }
//     //               if (dropdownItems.isEmpty) {
//     //                 for (var item in splitList) {
//     //                   String stu = item;
//     //                   var newItem = DropdownMenuItem(
//     //                     child: Text(stu),
//     //                     value: stu,
//     //                   );
//     //                   dropdownItems.add(newItem);
//     //                 }
//     //               }
//     //               return DropdownButton(
//     //                 isExpanded: false,
//     //                 value: student,
//     //                 items: dropdownItems,
//     //                 onChanged: (value) {
//     //                             Navigator.of(context)
//     //                       .pushReplacement(MaterialPageRoute(builder: (context) => (Results())));

//     //                   debugPrint('selected onchange: $value');
//     //                   setState(
//     //                     () {
//     //                       debugPrint('make selected: $value');
//     //                       student = value.toString();
//     //                       setDefaultMake = false;
//     //                       setDefaultMakeModel = true;
//     //                       loc.getLocation(student);
//     //                     },
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }

class GradeWidget extends StatelessWidget {
  GradeWidget({
    required this.student,
    Key? key,
  }) : super(key: key);

  final String student;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Results())),
          ),
          backgroundColor: Colors.red,
          title: Text(student),
          centerTitle: true,
        ),
      ),
    );
  }
}
