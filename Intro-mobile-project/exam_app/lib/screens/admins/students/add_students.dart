import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final addStudentsEditingController = new TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    final addStudentsField = TextFormField(
      autofocus: false,
      controller: addStudentsEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{5,}$');
        if (value!.isEmpty) {
          return "S-Number is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid student!";
        }
        return null;
      },
      onSaved: (value) {
        addStudentsEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 80, 20, 80),
          hintText: "S-numbers, separated with ';' ",
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
          //postDetailsToFirestore();
        },
        child: Text(
          "save",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Exams"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  //key: _formkey,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  addStudentsField,
                  SizedBox(height: 40),
                  saveButton,
                ],
              )),
            ),
          )),
        ));
  }

  //   postDetailsToFirestore() async {
  //   //calling fire store
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;

  //   //calling user model
  //   MyExam myExam = MyExam();
  //   myExam.uid = user!.uid;
  //   myExam.students = addStudentsEditingController.text;

  //   //sending values
  //   await firebaseFirestore
  //       .collection("exams")
  //       .doc(user.uid)
  //       .set(myExam.toMap());
  //   Fluttertoast.showToast(msg: "Students added successfully!");
  //   Navigator.pushAndRemoveUntil((context),
  //       MaterialPageRoute(builder: (context) => HomeAdmin()), (route) => false);
  // }
}