import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/view_contract_cho.dart';
import 'package:hayat_gp2_18/donations/published_request_cho.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/visulization.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
            label: const Text(
              "Sign out",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final user = await ParseUser.currentUser() as ParseUser;
              var response = await user.logout();

              if (response.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('User was successfully signed out!')),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginAll()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Can not signed out!')),
                );
              }
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
                      const Icon(
                        Icons.search,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Search Donations",
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
                          builder: (context) => PublishedContractC(
                                Cid: CHOid1,
                              )));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.article,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Contracts",
                          style: new TextStyle(fontSize: 20),
                          textAlign: TextAlign.center)
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
                      const Icon(
                        Icons.fact_check,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Published Requests",
                        style: new TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chart(Cid)));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.signal_cellular_alt,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Statistics",
                        style: new TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )
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
