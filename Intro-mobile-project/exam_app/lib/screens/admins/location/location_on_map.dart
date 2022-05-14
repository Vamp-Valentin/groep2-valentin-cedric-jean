import 'package:exam_app/screens/students/home/home.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter/material.dart';

class LocationOnMap extends StatefulWidget {
  LocationOnMap({Key? key}) : super(key: key);

  @override
  State<LocationOnMap> createState() => _LocationOnMapState();
   
}

class _LocationOnMapState extends State<LocationOnMap> {
  
  @override
  
   MapController controller = MapController(
                            initMapWithUserPosition: false,
                            initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
                            areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
                       );
    


  Widget build(BuildContext context) {
    return Container(child: Text("hey"),);
  }
}