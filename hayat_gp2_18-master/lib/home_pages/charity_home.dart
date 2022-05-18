import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/view_contract_cho.dart';
import 'package:hayat_gp2_18/donations/published_request_cho.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:hayat_gp2_18/visulization.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
          automaticallyImplyLeading: false,
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
            padding: EdgeInsets.all(20),
            child: GridView.count(crossAxisCount: 2, children: <Widget>[
              Card(
                elevation: 20,
                color: Colors.white,
                shape: const CircleBorder(),
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
                        Text("Search Donations",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 20,
                color: Colors.white,
                shape: const CircleBorder(),
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
                        Icon(
                          Icons.article,
                          size: 75,
                          color: Colors.teal,
                        ),
                        Text("Contracts",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 30,
                color: Colors.white,
                shape: const CircleBorder(),
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
                        Text("My Requests",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 30,
                color: Colors.white,
                shape: const CircleBorder(),
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
                        Icon(
                          Icons.signal_cellular_alt,
                          size: 75,
                          color: Colors.teal,
                        ),
                        Text("Statistics",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/charity.jpg"))),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/charity2.jpg"))),
              ),
            ])));
  }
}
