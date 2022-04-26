import 'package:exam_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //Register({Key? key}) : super(key: key);
  //final Function toggleView;
  //Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
      //validator: () {},
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
        onPressed: () {},
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
}
