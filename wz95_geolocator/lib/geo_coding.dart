/**
 * flutter pub add geocoding
 * import
 * 
 */

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';

class GeoCod extends StatefulWidget {
  const GeoCod({super.key, required this.title});
  final String title;
  @override
  State<GeoCod> createState() => _GeoCodState();
}

class _GeoCodState extends State<GeoCod> {
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

  void initState() {
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
      body: Center(
        child: Container(
            child: ElevatedButton(
          onPressed: () async {
            var cx = await getPosition();
            // List<Placemark> placemarks =await placemarkFromCoordinates(52.2165157, 6.9437819);
            List<Placemark> placemarks =
                await placemarkFromCoordinates(cx.latitude, cx.longitude);
            print("your current country is ${placemarks[0].country}");
            print(
                "your current ad_area is ${placemarks[0].administrativeArea}");
            // /////////////// OR:
            // List<Location> locations =  await locationFromAddress("Gronausestraat 710, Enschede");
            //************************* */
            // print(cx);
            List<Placemark> placemarks2 =
                await placemarkFromCoordinates(24.327077, 39.631053);
            print("your Distination country is ${placemarks2[0].country}");
            print(
                "your Distination ad_area is ${placemarks2[0].administrativeArea}");
            //*************************** */
            var distancebtw = Geolocator.distanceBetween(
                cx.latitude, cx.longitude, 24.327077, 39.631053);
            //********************************** */
            print("your jurney is : ${distancebtw / 1000} KM");
          },
          child: Text("get location"),
        )),
      ),
    );
  }
}
