import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(HomeAAA(22));
}

class HomeAAA extends StatefulWidget {
  var Cid;

  HomeAAA(this.Cid);
  @override
  _HomeState createState() => _HomeState(Cid);
}

class _HomeState extends State<HomeAAA> {
  var Cid;
  _HomeState(this.Cid);

  List<ParseObject> Charity = <ParseObject>[];
  List<ParseObject> alldonations = <ParseObject>[];
  List<ParseObject> donor = <ParseObject>[];
  List<String> foundDonors = <String>[];
  List foundDonorsSorted = [];

  List<double> distancesList = <double>[];
  List distancesListSorted = [];
  double distance = 0.0;

  final Set<Marker> donorMarkerLocs = new Set();

  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation =
      const LatLng(27.7089427, 85.3086209); //location to show in map

  @override
  void initState() {
    super.initState();
    getMarkers();

    ///arrangment();
    print('Cid');
    print(Cid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple Markers in Google Map"),
        backgroundColor: Colors.teal[200],
      ),
      body:
          /*GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 15.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
            getMarkers();
          });
        },
      ),*/
          Card(
        child: InkWell(
          onTap: () {
            arrangment();
          },
          splashColor: Colors.red,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("arrangment", style: new TextStyle(fontSize: 20))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCHOs() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery())
          ..whereEqualTo("objectId", Cid);

    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        Charity = apiResponse.results as List<ParseObject>;
        print('cho');
        print(Charity);
        print(Charity[0].get("name").toString());
        print(Charity[0].get("long"));
        print(Charity[0].get("lat"));
      });
      //add charity marker
      setState(() {
        markers.add(Marker(
          //add first marker

          markerId: MarkerId(Charity[0].get("name").toString()),
          position: LatLng(Charity[0].get("lat"),
              Charity[0].get("long")), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: 'Marker ' + Charity[0].get("name").toString(),
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
        print('marker added');
      });
      print('charity marker added');
    } else {
      Charity = [];
    }
    print('cho');
    print(Charity);
  }

  void getMarkers() async {
    getCHOs();
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'));

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        alldonations = apiResponse.results as List<ParseObject>;
        print('alldonations');
        print(alldonations);
        for (int i = 0; i < alldonations.length; i++) {
          var offer = alldonations[i];
          DateTime? dbOfferDate = DateTime.parse(offer.get("exp_date"));

          if (dbOfferDate.isBefore(DateTime.now())) {
            alldonations.remove(offer);
            alldonations.remove(offer);
            print("old remove");
          }
        }
      });
      print('alldonations2');
      print(alldonations);
      //   موقع كل دونر بدون تكرار
      for (int i = 0; i < alldonations.length; i++) {
        var donorId = alldonations[i].get("donor_ID");

        print('donorId');
        print(donorId);
        QueryBuilder<ParseUser> queryUsers =
            QueryBuilder<ParseUser>(ParseUser.forQuery())
              ..whereEqualTo("objectId", alldonations[i].get("donor_ID"));
        final ParseResponse apiResponse = await queryUsers.query();

        if (apiResponse.success && apiResponse.results != null) {
          setState(() {
            donor = apiResponse.results as List<ParseObject>;
            print('donor');
            print(donor[0]);
          });

          if (!foundDonors.contains(donor[0].get("objectId"))) {
            foundDonors.add(donor[0].get("objectId"));
            setState(() {
              markers.add(Marker(
                  markerId: MarkerId(donor[0].get("name").toString()),
                  position: LatLng(donor[0].get("lat"),
                      donor[0].get("long")), //position of marker
                  infoWindow: InfoWindow(
                    //popup info
                    title: 'Marker ' + donor[0].get("name").toString(),
                  ),
                  icon: BitmapDescriptor.defaultMarker, //Icon for Marker

                  onTap: () {
                    getDistance(donor[0].get("lat"), donor[0].get("long"));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$distance meters away from you')),
                    );
                  }));
              getDistance(donor[0].get("lat"), donor[0].get("long"));

              print('marker added');
            });
          }
          print('foundDonors');
          print(foundDonors);
        }
      }
      print('Markers');
      print(markers.length);
    } else {
      alldonations = [];
    }
  }

  void getDistance(double dLat, double dLon) async {
    double cLat = markers.elementAt(0).position.latitude;
    double cLon = markers.elementAt(0).position.longitude;

    distance = await Geolocator.distanceBetween(cLat, cLon, dLat, dLon);
    distancesList.add(distance);
    print(distance);
    print('list of distance');
    print(distancesList);
  }

  void arrangment() async {
    // distancesList.sort();
    var smallestValue = distancesList[0];
    var indexx;

//extract the first nearest distance
    for (int i = 0; i < foundDonors.length; i++) {
      for (int j = 0; j < distancesList.length; j++) {
        for (int z = 0; z < distancesList.length; z++) {
          if (distancesList[z] < distancesList[j]) {
            setState(() {
              smallestValue = distancesList[z];
            });

            indexx = z;
          }

          if (1 == distancesList.length) {
            setState(() {
              smallestValue = distancesList[z];
            });
            foundDonors.remove(foundDonors[indexx]);
          }
        }
      }
      distancesListSorted.add(smallestValue);
      distancesList.remove(smallestValue);
      foundDonorsSorted.add(foundDonors[indexx]);
    }
  }
}
