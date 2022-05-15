import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/admins/location/map.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:exam_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/my_exam.dart';

class LocationOnMap extends StatelessWidget {
  const LocationOnMap({Key? key, required this.student}) : super(key: key);
  final String student;

  @override
  Widget build(BuildContext context) {

    double lat = 37.4219983;
    double longlat = -122.084;
    String address = " ";

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: ()  async => Navigator.pushReplacement(
                await context, await MaterialPageRoute(builder: (context) => Results())),
          ),
          backgroundColor: Colors.red,
          title: Text("Location"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot> (
            stream: FirebaseFirestore.instance
                .collection('students')
                .orderBy('sNumber')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Container();
              List students = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                String stu = snapshot.data!.docs[i].get('sNumber');
                if (stu == student) {

                  lat = double.parse(snapshot.data!.docs[i].get('latitude'));
                  longlat =
                      double.parse(snapshot.data!.docs[i].get('longlatitude'));
                  locationToAdress(lat, longlat, stu);
                  address = snapshot.data!.docs[i].get('address');
                  return MapWidget(latitude: lat, longlatitude: longlat, address: address,);
                }
              }
              return Container();
            }),
      ),
    );
  }

  locationToAdress(double lat, double longlat, String student) async {
    final coordinates = new Coordinates(lat, longlat);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    String addres = "${first.featureName} : ${first.addressLine}";
    DatabaseService(uid: student).updateAddress(addres);
    return addres;
  }
}