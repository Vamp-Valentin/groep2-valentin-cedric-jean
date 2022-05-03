import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultipleChoice extends StatefulWidget {
  MultipleChoice({Key? key}) : super(key: key);

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {

  final AuthService _auth = AuthService();
  final questionEditingController = new TextEditingController();
  final possibilitiesEditingController = new TextEditingController();
  final answerEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    //question
    final questionField = TextFormField(
      autofocus: false,
      controller: questionEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Question is required!";
        }
        return null;
      },
      onSaved: (value) {
        questionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Question...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //posibil
    final possibilitiesField = TextFormField(
      autofocus: false,
      controller: possibilitiesEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Possibilities are required!";
        }
        return null;
      },
      onSaved: (value) {
        possibilitiesEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Posibilities, separated with ';' ",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //answer
    final answerField = TextFormField(
      autofocus: false,
      controller: answerEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Answer is required!";
        }
        return null;
      },
      onSaved: (value) {
        answerEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Answer",
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
          DatabaseService(uid: user.uid).updateMultipleChoiseQuestion(questionEditingController.text, possibilitiesEditingController.text, answerEditingController.text);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainQuestions()));
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
                  questionField,
                  SizedBox(height: 25),
                  possibilitiesField,
                  SizedBox(height: 25),
                  answerField,
                  SizedBox(height: 40),
                  saveButton,
                ],
              )),
            ),
          )),
        ));
  }
}