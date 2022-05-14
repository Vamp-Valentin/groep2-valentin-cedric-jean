import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/students/dropdown/student_dropdown.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationWidget extends StatefulWidget {
  final getLocation;
  final String? stu;
  const LocationWidget({Key? key, this.getLocation, this.stu}) : super(key: key);
  

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
      print(StudentDropdown().student.toString());
      DatabaseService(uid: StudentDropdown().student.toString()).updateLatitudeAndLonglatitude(currentPosition.latitude.toString(), currentPosition.longitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
