/**
 * Installing:
 * run: flutter pub add geolocator
 * import package:
 * android permission
 * 
 */

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GeoLoc extends StatefulWidget {
  const GeoLoc({super.key, required this.title});

  final String title;

  @override
  State<GeoLoc> createState() => _GeoLocState();
}

class _GeoLocState extends State<GeoLoc> {
  Future getPosition() async {
    var services = await Geolocator.isLocationServiceEnabled();
    if (!services) {
      AwesomeDialog(
        context: context,
        title: "services not Enabed",
        body: Text("services Not Enabled"),
      )..show();
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      AwesomeDialog(
        context: context,
        title: "Permission not Enabed",
        body: Text("Permission Not Enabled"),
      )..show();
      permission = await Geolocator.requestPermission();
      // print("denial");
    }
    return await Geolocator.getCurrentPosition().then((value) => value);
  }

  // @override
  // void initState() {
  //   getPosition();
  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            child: ElevatedButton(
          onPressed: () async {
            // print(cl.latitude);
            // print(cl.longitude);
            var cx = await getPosition();
            print("L_atitude:- ${cx.latitude}");
            print("Longitude:- ${cx.longitude}");
          },
          child: Text("get location"),
        )),
      ),
    );
  }
}
