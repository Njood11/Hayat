import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/offers/publish_offer.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';

class HomeD extends StatelessWidget {
  var Did;

  HomeD(this.Did) : super();

  @override
  Widget build(BuildContext context) {
    var Donorid1 = Did;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text("Logout"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginAll()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.article,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Contracts", style: new TextStyle(fontSize: 12))
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
                          builder: (context) => PublishOfferPage(
                                Donorid: Donorid1,
                              )));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.receipt_long,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Publish an offer",
                          style: new TextStyle(fontSize: 12))
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
                          builder: (context) => PublishOfferPage()));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.fact_check,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Published offers",
                          style: new TextStyle(fontSize: 12))
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.circle_notifications,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Notifications", style: new TextStyle(fontSize: 12))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 50, left: 100),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Dhome.jpeg'),
                      fit: BoxFit.cover)),
            ),
          ],
        ),
      ),
    );
  }
}
