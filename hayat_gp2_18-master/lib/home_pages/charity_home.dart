import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/view_contract_cho.dart';
import 'package:hayat_gp2_18/donations/published_request_cho.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:hayat_gp2_18/home_pages/charity_home_2.dart';
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
            margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
            padding: EdgeInsets.only(top: 25),
            child: GridView.count(crossAxisCount: 2, children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Card(
                  elevation: 20,
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chart(Cid)));
                    },
                    splashColor: Colors.red,
                    child: Container(
                      height: 180,
                      width: 180,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset('images/vis.jpg',
                              height: 110, fit: BoxFit.fill),
                          Text("Statistics",
                              style: new TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(),
              const SizedBox(),
              Align(
                alignment: Alignment.topRight,
                child: Card(
                  elevation: 20,
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeC2(Cid)));
                    },
                    splashColor: Colors.red,
                    child: Container(
                      height: 170,
                      width: 170,
                      child: Column(
                        children: <Widget>[
                          Image.asset('images/MydonationsTap.png',
                              fit: BoxFit.fill),
                          Text("Donations",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  elevation: 20,
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PublishedContractC(
                                    Cid: Cid,
                                  )));
                    },
                    splashColor: Colors.red,
                    child: Container(
                      height: 180,
                      width: 180,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset('images/ContractTap.png',
                              height: 120, fit: BoxFit.fill),
                          Text("Contracts",
                              style: new TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
