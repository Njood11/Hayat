import 'package:flutter/material.dart';

import 'package:hayat_gp2_18/home_pages/aboutus.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/home_pages/contactus.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';

import 'package:hayat_gp2_18/signin/signin_all.dart';

import 'package:hayat_gp2_18/signup/signup_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hayat food donation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Hayat food donation',
          ),
          backgroundColor: Colors.teal[200],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: EdgeInsets.only(),
              child: GridView.count(crossAxisCount: 2, children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 45,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Welcome',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.teal[200],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOffersPage3()));
                    },
                    splashColor: Colors.red,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image(image: AssetImage("images/Logo.jpg")),
                          Text("What is Hayat",
                              style: new TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeContact()));
                    },
                    splashColor: Colors.red,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.contact_support,
                            size: 90,
                            color: Colors.teal,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text("Contact us", style: new TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignupAll()));
                    },
                    splashColor: Colors.red,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle_outline,
                            size: 75,
                            color: Colors.teal,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text("Sign up", style: new TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginAll()));
                    },
                    splashColor: Colors.red,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.login,
                            size: 75,
                            color: Colors.teal,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text("Sign in ", style: new TextStyle(fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ));
  }
}
