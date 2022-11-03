/**
 * wz 107 - live location
 */

import 'dart:async';
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GoogMps5 extends StatefulWidget {
  const GoogMps5({super.key, required this.title});
  final String title;

  @override
  State<GoogMps5> createState() => _GoogMps5State();
}

class _GoogMps5State extends State<GoogMps5> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? gmc; //wz102
  Position? x;
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.9757, 31.13084),
    zoom: 12,
  );
  // final LocationSettings locationSettings = LocationSettings(
  //   accuracy: LocationAccuracy.high,
  //   distanceFilter: 100,
  // );
  // StreamSubscription<Position> positionStream =
  //     Geolocator.getPositionStream().listen((Position? position) {
  //   print(position == null
  //       ? 'Unknown'
  //       : 'lat= ${position.latitude.toString()} ,Long= ${position.longitude.toString()}');
  // });

  Set<Marker> myMarker = {
    Marker(
      markerId: MarkerId("1"),
      infoWindow: InfoWindow(title: "Mecca"),
      position: LatLng(21.422581, 39.826145),
    ),
    Marker(
      markerId: MarkerId("2"),
      infoWindow: InfoWindow(title: "My Home"),
      position: LatLng(29.9998269, 31.117893),
    ),
  };

  markHere() async {
    x = await Geolocator.getCurrentPosition().then((value) => value);
    // print(myMarker.length);
    myMarker.add(Marker(
      markerId: MarkerId("4"),
      infoWindow: InfoWindow(
        title: "Here",
        onTap: () {
          print("info marker");
        },
      ),
      position: LatLng(x!.latitude, x!.longitude),
      onTap: () {
        print("home marker");
      },
      draggable: true,
      onDragEnd: (LatLng x) {
        print(x);
      },
      /*
      icon: await BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure),
      */
      /*
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/icons/icon.png",
      ),
      */
    ));
    // setState(() {});
    // print(myMarker.length);
  }

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
    markHere();
    // ps = Geolocator.getPositionStream().listen((Position p) {
    //   print((p == null) ? "unknown" : p.latitude.toString());
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.location_city)),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  // margin: EdgeInsets.all(20.0),
                  width: 500.0,
                  height: 500.0,
                  child: GoogleMap(
                    onTap: (x) {
                      // myMarker.remove(Marker(markerId: MarkerId("1"))); // not working
                      myMarker.add(
                        Marker(
                          markerId: MarkerId((myMarker.length + 2).toString()),
                          // MarkerId("1"),
                          infoWindow: InfoWindow(
                              title: (myMarker.length + 1).toString()),
                          position: x,
                        ),
                      );
                      // print(x);
                      setState(() {});
                    },
                    markers: myMarker,
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      gmc = controller; //wz102
                    },
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              print(await getPosition());
            },
            child: Text("show lat long"),
          ),
          SizedBox(
            height: 10.0,
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
        onPressed: _goToTheHere,
        label: Text('Find Here'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheHere() async {
    Position cx = await getPosition();
    final CameraPosition _kHome = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(cx.latitude, cx.longitude),
        // tilt: 59.440717697143555,
        zoom: 16.1519);
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
    // print("${p2.latitude} , ${p2.longitude}");
    var p3 = await gmc!.getZoomLevel();
    // print(p3);
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
