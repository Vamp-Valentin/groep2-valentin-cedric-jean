import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/my_exam.dart';


class LocationOnMap extends StatefulWidget {
  LocationOnMap({Key? key}) : super(key: key);

  @override
  State<LocationOnMap> createState() => _LocationOnMapState();
   
}

class _LocationOnMapState extends State<LocationOnMap> {
  
Widget build(BuildContext context) {
  
  return new FlutterMap(
    options: new MapOptions(
      center: new LatLng(43, -0.09),
      zoom: 13.0,
    ),
    layers: [
      new TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c']
      ),
      new MarkerLayerOptions(
        markers: [
          new Marker(
            width: 40.0,
            height: 40.0,
            point: new LatLng(43, -0.09),
            builder: (ctx) =>
            new Container(
              child: new FlutterLogo(),
            ),
          ),
        ],
      ),
    ],
  );
}
}