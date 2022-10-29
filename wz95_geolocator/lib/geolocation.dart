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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text("Geolocator"),
        ),
      ),
    );
  }
}
