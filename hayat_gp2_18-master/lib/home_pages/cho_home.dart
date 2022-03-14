import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/offers/published_request_cho.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';

class HomeC extends StatelessWidget {
  var Cid;
  HomeC(this.Cid) : super();

  @override
  Widget build(BuildContext context) {
    var CHOid1 = Cid;

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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListOffersPage3(Cid: Cid)));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Search Offers", style: new TextStyle(fontSize: 12))
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
                          builder: (context) => publishedRequestCHO(Cid)));
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
                      Text("Published Requests",
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
                        Icons.signal_cellular_alt,
                        size: 75,
                        color: Colors.teal,
                      ),
                      Text("Statistics", style: new TextStyle(fontSize: 12))
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
            Container(
              padding: EdgeInsets.only(top: 85, left: 19),
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/CHO.jpg"))),
            ),
          ],
        ),
      ),
    );
  }
}
