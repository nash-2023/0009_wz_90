/**
 * GOOGLE MAPS FLUTTER FOR ONLY ANDROID AND IOS 
 * flutter pub add google_maps_flutter
 * api key : AIzaSyCaiM2k6SMWSqmpE14IDII3Duh16mIJ6XE
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GoogMps extends StatefulWidget {
  const GoogMps({super.key, required this.title});
  final String title;

  @override
  State<GoogMps> createState() => _GoogMpsState();
}

class _GoogMpsState extends State<GoogMps> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    // target: LatLng(37.42796133580664, -122.085749655962),
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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

  @override
  void initState() {
    // TODO: implement initState
    getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(20.0),
            width: 500.0,
            height: 500.0,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheHome,
        label: Text('To the Home!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> _goToTheHome() async {
    Position cx = await getPosition();
    final CameraPosition _kHome = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(cx.latitude, cx.longitude),
        // tilt: 59.440717697143555,
        zoom: 16.151926040649414);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
  }
}
