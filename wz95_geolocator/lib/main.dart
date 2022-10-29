import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:wz95_geolocator/awe_dial.dart';
import 'package:wz95_geolocator/geo_locator.dart';
import 'package:wz95_geolocator/geo_coding.dart';
import 'package:wz95_geolocator/google_mps.dart';
import 'package:wz95_geolocator/google_mps_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fancy Dialog Example',
      theme: ThemeData.light(),
      // home: const AweDial(title: 'Fancy Dialog Example'),
      // home: GeoLoc(title: 'Geo Location'),
      // home: GeoCod(title: 'Geo Code'),
      home: GoogMps(title: 'Google Maps'),
    );
  }
}
