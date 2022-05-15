import 'package:exam_app/models/my_student.dart';
import 'package:exam_app/screens/students/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

import '../../../models/my_exam.dart';

class LocationOnMap extends StatefulWidget {
  LocationOnMap({Key? key}) : super(key: key);

  @override
  State<LocationOnMap> createState() => _LocationOnMapState();

    _getLocation() async
      {
        final coordinates = new Coordinates(51.3012, 4.4891);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        print("${first.featureName} : ${first.addressLine}");
      }
}

class _LocationOnMapState extends State<LocationOnMap> {
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(51.3012, 4.4891),
        zoom: 15.0,
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 40.0,
              height: 40.0,
              point: new LatLng(51.3012, 4.4891),
              builder: (ctx) => new Container(
                child: new Icon(Icons.location_on, color: Colors.red,)
              ),
            ),
          ],
        ),
      ],
    );
  }
}
