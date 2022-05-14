import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key, this.student}) : super(key: key);
  final String? student;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {

  @override
  void initState() {
    super.initState();
    getLocation();

  }

  Position? position;
  final AuthService _auth = AuthService();

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    String latitude;
    String longlatitude;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Location services are disabled.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Location permissions are denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      position = currentPosition;

      latitude = currentPosition.latitude.toString();
      longlatitude = currentPosition.longitude.toString();
            print(latitude);
      print(longlatitude);
      DatabaseService(uid: "").updateLatitudeAndLonglatitude(currentPosition.latitude.toString(), currentPosition.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // String student = "";
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 50,
    //         ),
    //         StreamBuilder<QuerySnapshot>(
    //             stream:
    //                 FirebaseFirestore.instance.collection('students').snapshots(),
    //             builder: (BuildContext context,
    //                 AsyncSnapshot<QuerySnapshot> snapshot) {
    //               if (!snapshot.hasData) return Container();
    //               student = snapshot.data!.docs[0].get('sNumber');
                  
    //               return Text(
    //                 '$student',
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                     fontSize: 50),
    //               );
    //             }),
    //         SizedBox(height: 20),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocator Package in Flutter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(position == null ? "Location" : position.toString()),
            ElevatedButton(
              onPressed: () {
                getLocation();
              },
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
