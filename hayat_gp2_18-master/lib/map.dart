import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class map extends StatefulWidget {
  static final pageName = '/Screen3';

  final double longitude;
  final double latitude;

  map({required this.longitude, required this.latitude});

  @override
  _map createState() => _map(longitude, latitude);
}

class _map extends State<map> {
  @override
  var longitude;
  var latitude;
  _map(this.longitude, this.latitude);
  void initState() {
    // TODO: implement initState
    super.initState();
    customIcon();
  }

  late BitmapDescriptor myCustomIcon;

  void customIcon() async {
    myCustomIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), '/images/avatar.png');
  }

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> allMarkers = [];
/*
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text("Screen3"),
      )),
      body: Container(
          child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            print('longitude');
            print(longitude);
            print('latitude');
            print(latitude);
            allMarkers = [
              Marker(
                  icon: myCustomIcon,
                  onTap: () {
                    _goToTheLake(latitude, longitude);
                    print('this is the user location .,');
                  },
                  infoWindow: InfoWindow(title: 'User location  '),
                  markerId: MarkerId('third'),
                  position: LatLng(latitude, longitude)),
            ];
          });
        },
        markers: Set.from(allMarkers),
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0),
      )),
      /*   floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake(double lat, double long) async {
    final CameraPosition A = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(A));
  }
}
