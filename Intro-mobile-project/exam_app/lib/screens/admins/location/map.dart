import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/admins/results/results.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/my_exam.dart';

class MapWidget extends StatelessWidget {
  const MapWidget(
      {Key? key, required this.latitude, required this.longlatitude})
      : super(key: key);
  final double latitude;
  final double longlatitude;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(latitude, longlatitude),
            zoom: 15.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 40.0,
                  height: 40.0,
                  point: new LatLng(latitude, longlatitude),
                  builder: (ctx) => new Container(
                      child: new Icon(
                    Icons.location_on,
                    color: Colors.red,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
