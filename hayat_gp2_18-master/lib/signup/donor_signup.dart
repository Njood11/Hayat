import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hayat_gp2_18/signin/donor_signin.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:encrypt/encrypt.dart';
import 'package:hayat_gp2_18/encryption.dart';
import 'package:hayat_gp2_18/signup/signup_all.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class DSignupPage extends StatefulWidget {
  const DSignupPage() : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<DSignupPage> {
  //var ad;
  //_HomeState( this.ad);
  List<ParseObject> results = <ParseObject>[];

  bool response2 = false;
  late String e_mail;
  late String pass;
  late String _name;
  String eType = 'Establishment Type';
  late int phone1;
  late String location2 = '';
  late String _usernameError;
  late String ErrorMesLoc = '';
  late String x = '';

  var allDonorswithEmail = [];
  var elements = [];
  var allDonorswithEmail2 = [];
  var elements2 = [];

  var encryptedPass;

  final List<String> items = [
    'Hotel',
    'Resturant',
    'Other',
  ];

  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();

  final formKey = GlobalKey<FormState>(); //key for form

  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _hasCapitalCharacter = false;
  bool _hasLowerCaseCharacter = false;
  bool _hasSpecialCharacter = false;
  String location = 'Null, Press Button';

  static String add = 'no location selected yet';
  static bool result = false;
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    print('serviceEnabled');

    print(serviceEnabled);

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print('permission');

    print(permission);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> _getPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    add =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      add =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  void doQueryNear() async {
    // Create your query
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('City'));

    // Get current position from device
    final position = await getCurrentPosition();

    final currentGeoPoint = ParseGeoPoint(
        latitude: position.latitude, longitude: position.longitude);

    // `whereNear` will order results based on distance between the GeoPoint
    // type field from the class and the GeoPoint argument
    parseQuery.whereNear('location', currentGeoPoint);

    // The query will resolve only after calling this method, retrieving
    // an array of `ParseObjects`, if success
    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      for (var o in apiResponse.results! as List<ParseObject>) {
        print(
            'City: ${o.get<String>('name')} - Location: ${o.get<ParseGeoPoint>('location')!.latitude}, ${o.get<ParseGeoPoint>('location')!.longitude}');
      }

      setState(() {
        results = apiResponse.results as List<ParseObject>;
      });
    } else {
      setState(() {
        results.clear();
      });
    }
  }

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final capitalRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final specialCharRegex = RegExp(r'[#?!@$%^&*-]');

    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;

      _hasCapitalCharacter = false;
      if (capitalRegex.hasMatch(password)) _hasCapitalCharacter = true;

      _hasLowerCaseCharacter = false;
      if (lowerCaseRegex.hasMatch(password)) _hasLowerCaseCharacter = true;

      _hasSpecialCharacter = false;
      if (specialCharRegex.hasMatch(password)) _hasSpecialCharacter = true;
    });
  }

  Text getDynamicText(String add) {
    if (add == 'no location selected yet') {
      return Text('no location selected yet');
    } else
      return Text('$add');
  }

  ////database cloud add donor functions//////

  void addDonor() async {
    Position position = await getCurrentPosition();
    final donor = ParseUser(
        emailController.text.toLowerCase(), encryptedPass, emailController.text)
      ..set('location', add)
      ..set('type', eType)
      ..set('phone', phone1)
      ..set('userType', 'donor')
      ..set('name', nameController.text)
      ..set('long', position.longitude)
      ..set('lat', position.latitude);

    var response = await donor.signUp();
    print(response);
    if (response.success) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, 'OK');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginDonor()),
          );
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Success!"),
        content: Text(
            "Account signed up successfully, please check your email to verify it!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (response.success == false) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context, 'OK');
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text("Account already exists for this email!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupAll()),
            );
          },
        ),
        backgroundColor: Colors.teal[200],
        title: Text('Hayat food donation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up with us",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Create an account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      controller: nameController,
                      onChanged: (value) {
                        _name = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.supervised_user_circle),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Column(
                      children: <Widget>[
                        new ListTile(
                            title: new DropdownButton(
                          borderRadius: BorderRadius.circular(10),
                          hint: eType == null
                              ? Text('-----')
                              : Text(
                                  eType,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: items.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                eType = val.toString();
                              },
                            );
                          },
                        )),
                        Column(children: <Widget>[
                          if (eType == "Other")
                            Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'What is the type',
                                  ),
                                  onChanged: (value) {
                                    eType = value;
                                  },
                                ),
                              ],
                            ),
                        ])
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(70),
                        ],
                        onChanged: (value) {
                          e_mail = value;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value))
                            return 'Enter a valid email address:name@domain.com';
                          else if (x == 'This email already used') {
                            return 'This email already used';
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: passController,
                        onChanged: (value) {
                          pass = value;
                          onPasswordChanged(value);
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.security),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                                  .hasMatch(value) ||
                              value == null)
                            return 'Enter valid password';
                          else if (value != null) {
                            pass = passController.text;
                            encryptedPass =
                                EncryptionDecryption.encryptAES(pass);

                            encryptedPass = encryptedPass.base64;

                            return null;
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _isPasswordEightCharacters
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _isPasswordEightCharacters
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least 8 characters.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasPasswordOneNumber
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasPasswordOneNumber
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least one number.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasCapitalCharacter
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasCapitalCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least one capital letter.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasLowerCaseCharacter
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasLowerCaseCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least one lower case letter.")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: _hasSpecialCharacter
                                  ? Colors.green
                                  : Colors.transparent,
                              border: _hasSpecialCharacter
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Contains at least one special character.")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          var phoneint = int.parse(value);
                          phone1 = phoneint;
                        },
                        controller: phoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 16),
                          labelText: 'Phone number',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          var str = value.toString();

                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                                  .hasMatch(value) ||
                              value == null ||
                              !str.startsWith('05'))
                            return 'Please enter a valid phone number';
                          else if (phone1.toString().length < 10)
                            return 'Enter a valid phone number of 10 digits';
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Location address: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          //  margin: const EdgeInsets.only(bottom: 60.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.teal[100]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                              ),
                              onPressed: () async {
                                Position position = await getCurrentPosition();
                                if (_HomeState.result == true) {
                                  GetAddressFromLatLong(position);
                                }

                                location =
                                    'Lat: ${position.latitude} , Long: ${position.longitude}';
                                //  GetAddressFromLatLong(position);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return map(
                                        latitude: position.latitude,
                                        longitude: position.longitude,
                                      );
                                    });
                              },
                              child: Text('Enter your Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ))),
                        ),
                      ],
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.location_history),
                        title: Text(/*_HomeState.result.toString()*/ ''),
                        subtitle: getDynamicText(add),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ErrorMesLoc,
                        style: TextStyle(
                          color: Colors.red[800],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () async {
                            if (_HomeState.result == false) {
                              setState(() {
                                ErrorMesLoc = '   please enter your location';
                              });
                            } else
                              setState(() {
                                ErrorMesLoc = '';
                              });

                            if (formKey.currentState!.validate() &&
                                _HomeState.result == true) {
                              addDonor();

                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            } else {
                              print('Error');
                              print(ErrorMesLoc);
                            }
                          },
                          color: Colors.teal[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          splashColor: Colors.red),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account?"),
                    GestureDetector(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginDonor()),
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class map extends StatefulWidget {
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
    super.initState();
    customIcon();
  }

  late BitmapDescriptor myCustomIcon;
  String Address = '';

  void customIcon() async {
    myCustomIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), '/images/avatar.png');
  }

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> allMarkers = [];
  bool appearlocation = false;
  @override
  Future<Position> _getGeoLocationPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    _HomeState.add =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      _HomeState.add =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: GoogleMap(
            myLocationButtonEnabled: false,
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
                      infoWindow: InfoWindow(title: 'your location'),
                      markerId: MarkerId('third'),
                      position: LatLng(latitude, longitude)),
                ];
              });
            },
            markers: Set.from(allMarkers),
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await _getGeoLocationPosition();

            _HomeState.result = true;

            setState(() {
              _HomeState.result = true;
              _HomeState.add = Address;
            });
            if (_HomeState.result == true) {
              GetAddressFromLatLong(position);
            }
            print('Confirm my location button');
            print(_HomeState.result);
            Navigator.pop(context);
          },
          label: Text('Confirm my location'),
          icon: Icon(Icons.location_history),
        ));
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
