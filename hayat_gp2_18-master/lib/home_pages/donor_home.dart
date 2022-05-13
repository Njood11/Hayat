import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/cho_list.dart';
import 'package:hayat_gp2_18/contract/view_contract_donor.dart';
import 'package:hayat_gp2_18/donations/publish_offer.dart';
import 'package:hayat_gp2_18/donations/view_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => listCHO(Did)));
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
                      Text("Contracts", style: new TextStyle(fontSize: 20))
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
                                Donorid: Did,
                              )));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.receipt_long,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Publish new donation",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PublishedContract(
                                Did,
                              )));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.assignment_outlined,
                        size: 90,
                        color: Colors.teal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "View published contracts",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PublishedOffers(
                                Donorid1,
                              )));
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
                        "View published donations",
                        style: new TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )
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
