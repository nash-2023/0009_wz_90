import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:wz95_geolocator/awe_dial.dart';
import 'package:wz95_geolocator/geo_locator.dart';
import 'package:wz95_geolocator/geo_coding.dart';
import 'package:wz95_geolocator/google_mps.dart';
import 'package:wz95_geolocator/google_mps_2.dart';
import 'package:wz95_geolocator/google_mps_3.dart';
import 'package:wz95_geolocator/google_mps_4.dart';
import 'package:wz95_geolocator/google_mps_5.dart';

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
      title: 'Fancy Map',
      theme: ThemeData.light(),
      // home: const AweDial(title: 'Fancy Dialog Example'),
      // home: GeoLoc(title: 'Geo Location'),
      // home: GeoCod(title: 'Geo Code'),
      // home: GoogMps(title: 'Google Maps'),
      // home: GoogMps2(title: 'Google Maps'),
      // home: GoogMps3(title: 'Google Maps'),
      // home: GoogMps4(title: 'Google Maps'),
      home: GoogMps5(title: 'Google Maps'),
    );
  }
}
