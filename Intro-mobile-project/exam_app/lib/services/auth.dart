import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService{
    //final -> cannot change, _fire -> private
  final FirebaseAuth _auth = FirebaseAuth.instance;

    //create user obj
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

    // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

    Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  //sign in with email & password
   // login function
   
  //register with email & password

  // sign out 
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
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