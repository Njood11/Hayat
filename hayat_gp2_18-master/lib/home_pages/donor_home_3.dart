import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/cho_list.dart';
import 'package:hayat_gp2_18/contract/contract_form.dart';
import 'package:hayat_gp2_18/contract/view_contract_donor.dart';
import 'package:hayat_gp2_18/donations/publish_offer.dart';
import 'package:hayat_gp2_18/donations/view_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeD3 extends StatelessWidget {
  var Did;

  HomeD3(this.Did) : super();

  @override
  Widget build(BuildContext context) {
    var Donorid1 = Did;
    print(Donorid1);
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
        padding: EdgeInsets.all(35),
        child: GridView.count(
          crossAxisCount: 1,
          children: <Widget>[
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
                      Image.asset('images/donationsTap.jpg',
                          width: 210, height: 150, fit: BoxFit.contain),
                      Text(
                        "\nMy donations",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
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
                          builder: (context) => PublishOfferPage(
                                Donorid: Did,
                              )));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.add_circle,
                        size: 75,
                        color: Colors.teal[200],
                      ),
                      Text(
                        "\n\nPublish new donation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
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
            ),
          ],
        ),
      ),
    );
  }
}
