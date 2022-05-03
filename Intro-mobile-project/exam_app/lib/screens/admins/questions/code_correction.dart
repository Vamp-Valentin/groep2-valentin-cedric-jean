import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:exam_app/screens/admins/questions/question_home.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodeCorrection extends StatefulWidget {
  CodeCorrection({Key? key}) : super(key: key);

  @override
  State<CodeCorrection> createState() => _CodeCorrectionState();
}

class _CodeCorrectionState extends State<CodeCorrection> {
  
  final AuthService _auth = AuthService();
  final wrongCodeEditingController = new TextEditingController();
  final correctCodeEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final wrongCodeField = TextFormField(
      autofocus: false,
      controller: wrongCodeEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "code is required!";
        }
        return null;
      },
      onSaved: (value) {
        wrongCodeEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Wrong code...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final correctCodeField = TextFormField(
      autofocus: false,
      controller: correctCodeEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Code is required!";
        }
        return null;
      },
      onSaved: (value) {
        correctCodeEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Correct code...",
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
          DatabaseService(uid: user.uid).updateCodeCorrectionQuestion(wrongCodeEditingController.text, correctCodeEditingController.text);
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
          title: Text("Code correction question"),
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
                  wrongCodeField,
                  SizedBox(height: 25),
                  correctCodeField,
                  SizedBox(height: 40),
                  saveButton,
                ],
              )),
            ),
          )),
        ));
  }
}
