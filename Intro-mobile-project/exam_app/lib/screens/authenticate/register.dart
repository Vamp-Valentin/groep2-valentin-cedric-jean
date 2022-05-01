import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_user.dart';
import 'package:exam_app/screens/home/home.dart';
import 'package:exam_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  //Register({Key? key}) : super(key: key);
  //final Function toggleView;
  //Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //final AuthService _auth = AuthService();
  //firebase
  final _auth = FirebaseAuth.instance;

  //form key
  final _formkey = GlobalKey<FormState>();

  // editing controller
  final sNumberEditingController = new TextEditingController();
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  //text field state
  String email = ' ';
  String password = ' ';

  @override
  Widget build(BuildContext context) {
    //s number
    final sNumberField = TextFormField(
      autofocus: false,
      controller: sNumberEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{7,}$');
        if (value!.isEmpty) {
          return "S-Number is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid password, min 7 characters!";
        }
        return null;
      },
      onSaved: (value) {
        sNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "S-Number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //first name
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return "First name is required!";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid first name!";
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //last name
    final lastNameField = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return "Last name is required!";
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //email
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //password
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return "Password is required";
        }
        if (!regex.hasMatch(value)) {
          return "Please enter valid password, min 6 characters!";
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //confirm password
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text != passwordEditingController.text) {
          return "Passwords dont match!";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    //sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 180,
                          child: Image.asset(
                            "assets/apLogo.png",
                            fit: BoxFit.contain,
                          )),
                      SizedBox(height: 45),
                      sNumberField,
                      SizedBox(height: 20),
                      firstNameField,
                      SizedBox(height: 20),
                      lastNameField,
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 20),
                      passwordField,
                      confirmPasswordField,
                      SizedBox(height: 20),
                      signUpButton,
                      SizedBox(height: 35),
                    ],
                  )),
            ),
          )),
        ));
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(255, 252, 237, 238),
    //   appBar: AppBar(
    //     backgroundColor: Colors.red[400],
    //     elevation: 0.0,
    //     title: Text('Sign Up'),
    //     actions: <Widget>[
    //       FlatButton.icon(
    //         icon: Icon(Icons.person),
    //         label: Text('Sign In'),
    //         onPressed: () {
    //           //widget.toggleView();
    //         })
    //     ],
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
    //     child: Form(
    //       child: Column(
    //         children: <Widget>[
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             validator: (String? value) {
    //                   if (value != null && value.isEmpty) {
    //                     return "Username can't be empty";
    //                   }
    //                   return null;
    //                 },
    //             onChanged: (val) {
    //               setState(() => email = val);
    //             }
    //           ),
    //           SizedBox(height: 20.0),
    //           TextFormField(
    //             obscureText: true,
    //             validator: (String? value) {
    //                   if (value != null && value.length > 6) {
    //                     return "password can't be empty";
    //                   }
    //                   return null;
    //                 },
    //             onChanged: (val) {
    //               setState(() => password = val);

    //             },
    //           ),
    //           SizedBox(height: 20.0),
    //           ElevatedButton(
    //                 child: Text('Register'),
    //                 style: ButtonStyle(
    //                     backgroundColor:
    //                         MaterialStateProperty.all(Colors.pink[400]),
    //                     textStyle: MaterialStateProperty.all(
    //                         TextStyle(color: Colors.white))),
    //                 onPressed: () async {
    //                   if (_fromkey.currentState!.validate()){
    //                   print(email);
    //                   print(password);
    //                 }
    //                 },
    //               )
    //         ],
    //       ),
    //     )
    // ));
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling fire store
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    //calling user model
    MyUser myUser = MyUser();
    myUser.email = user!.email;
    myUser.uid = user.uid;
    myUser.firstName = firstNameEditingController.text;
    myUser.lastName = lastNameEditingController.text;

    //sending values
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(myUser.toMap());
    Fluttertoast.showToast(msg: "Account created successfully!");
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
