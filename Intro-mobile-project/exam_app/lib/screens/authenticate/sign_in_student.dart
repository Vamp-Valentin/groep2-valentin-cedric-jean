import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/authenticate/authenticate.dart';
import 'package:exam_app/screens/authenticate/register.dart';
import 'package:exam_app/screens/students/dropdown/student_dropdown.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInStudent extends StatefulWidget {
  //final Function toggleView;
  //SignIn({required this.toggleView});

  @override
  State<SignInStudent> createState() => _SignInStudentState();
}

class _SignInStudentState extends State<SignInStudent> {
  //auth class
  //final AuthService _auth = AuthService();

  //from key
  //final _formkey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  //text field state
  String email = '';
  String password = '';

  User? user = FirebaseAuth.instance.currentUser;
  MyUser loggedInUser = MyUser();
  MyExam exam = MyExam();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StudentDropdown(),
    );
  }
}
