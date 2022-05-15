import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/admins/location/map.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Results())),
          ),
          backgroundColor: Colors.red,
          title: Text("location"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
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
                  return MapWidget(latitude: lat, longlatitude: longlat);
                }
              }
              return Container();
            }),
      ),
    );
  }
}
              // new FlutterMap(
              //   options: new MapOptions(
              //     center: new LatLng(51.3012, 4.4891),
              //     zoom: 15.0,
              //   ),
              //   layers: [
              //     new TileLayerOptions(
              //         urlTemplate:
              //             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              //         subdomains: ['a', 'b', 'c']),
              //     new MarkerLayerOptions(
              //       markers: [
              //         new Marker(
              //           width: 40.0,
              //           height: 40.0,
              //           point: new LatLng(51.3012, 4.4891),
              //           builder: (ctx) => new Container(
              //               child: new Icon(
              //             Icons.location_on,
              //             color: Colors.red,
              //           )),
              //         ),
              //       ],
              //     ),
              //   ],