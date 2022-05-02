import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var students, carMakeModel;
  var setDefaultMake = true, setDefaultMakeModel = true;
  User? user = FirebaseAuth.instance.currentUser;
  MyUser loggedInUser = MyUser();
  MyExam exam = MyExam();
  

  @override
  void initState() {
    super.initState();
    if (user?.uid != null) {
      FirebaseFirestore.instance.collection("exams").doc(user!.uid).get().then(
          (value) =>
              {this.exam = MyExam.fromMap(value.data()), setState(() {})});
    }
  }

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
                      for (int i = 0; i < splitstudents.length; i++) {
                        splitList.add(splitstudents?[i]);
                        debugPrint(splitList[i]);
                      }
                      student = splitList[0];
                    }
                    for (var item in splitList) {
                      String currency = item;
                      var newItem = DropdownMenuItem(
                        child: Text(currency),
                        value: currency,
                      );
                      dropdownItems.add(newItem);
                    }
                  return DropdownButton(
                    isExpanded: false,
                    value: student,
                    items: dropdownItems,
                    onChanged: (value) {
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

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // User? user = FirebaseAuth.instance.currentUser;
  // MyUser loggedInUser = MyUser();
  // MyExam exam = MyExam();

  // @override
  // void initState() {
  //   super.initState();
  //   if(user?.uid != null){
  //   FirebaseFirestore.instance.collection("exams").doc(user!.uid).get().then(
  //       (value) => {
  //             this.exam = MyExam.fromMap(value.data()),
  //             setState(() {})
  //           });
  // }}
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