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

class GoogMps2 extends StatefulWidget {
  const GoogMps2({super.key, required this.title});
  final String title;

  @override
  State<GoogMps2> createState() => _GoogMps2State();
}

class _GoogMps2State extends State<GoogMps2> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? gmc; //wz102

  Position? x;
  CameraPosition? _kGooglePlex;

  Future getPermission() async {
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
      permission = await Geolocator.requestPermission();
    }
    // print("permession :- ${permission}");
    return permission;
  }

  Future getPosition() async {
    x = await Geolocator.getCurrentPosition().then((value) => value);
    _kGooglePlex = CameraPosition(
      target: LatLng(x!.latitude, x!.longitude),
      zoom: 13.0000,
    );
    setState(() {});
    return x;
  }

  @override
  void initState() {
    // TODO: implement initState
    getPermission();
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
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (_kGooglePlex == null)
              ? CircularProgressIndicator()
              : Container(
                  margin: EdgeInsets.all(20.0),
                  width: 500.0,
                  height: 500.0,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      gmc = controller; //wz102
                    },
                  ),
                ),
          ElevatedButton(
            onPressed: () async {
              print(await getPosition());
            },
            child: Text("show lat long"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _gotoMecca();
            },
            child: Text("Go To Mecca"),
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

  Future<void> _goToTheHome() async {
    Position cx = await getPosition();
    final CameraPosition _kHome = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(cx.latitude, cx.longitude),
        // tilt: 59.440717697143555,
        zoom: 14.1519);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
  }

  Future<void> _gotoMecca() async {
    final CameraPosition _kMecc = CameraPosition(
      target: LatLng(21.422581, 39.826145),
      zoom: 14.1519,
    );
    final LatLng _ltlngMecc = new LatLng(21.422581, 39.826145);
    // final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
    await gmc!.animateCamera(CameraUpdate.newCameraPosition(_kMecc));
    // await gmc!.animateCamera(CameraUpdate.newLatLng(_ltlngMecc));
    var p2 = await gmc!.getLatLng(ScreenCoordinate(x: 250, y: 250));
    print("${p2.latitude} , ${p2.longitude}");
    var p3 = await gmc!.getZoomLevel();
    print(p3);
  }
}

/**
 * print(_kGooglePlex.target.latitude);
 * 
 * // CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(0, 0),
  //   zoom: 14.4746,
  // );
 * 
 * 
 */