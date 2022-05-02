import 'package:exam_app/models/my_exam.dart';
import 'package:exam_app/screens/admins/home/homeAdmin.dart';
import 'package:flutter/material.dart';

class Open extends StatefulWidget {
  Open({Key? key}) : super(key: key);

  @override
  State<Open> createState() => _OpenState();
}

class _OpenState extends State<Open> {
  final openQuestionEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final exam = ModalRoute.of(context)!.settings.arguments as MyExam;
    //exam Name
    final openQuestionField = TextFormField(
      autofocus: false,
      controller: openQuestionEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return "Question is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid question!";
        }
        return null;
      },
      onSaved: (value) {
        openQuestionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Question...",
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => HomeAdmin(
          //             : exam,
          //           )),
          // );
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
          title: Text("Open question"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              ;
            },
          ),
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
                  openQuestionField,
                  SizedBox(height: 70),
                  saveButton,
                  SizedBox(height: 25),
                ],
              )),
            ),
          )),
        ));
  }
}
