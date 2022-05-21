import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/contract/cho_list.dart';
import 'package:hayat_gp2_18/contract/contract_form.dart';
import 'package:hayat_gp2_18/contract/view_contract_donor.dart';
import 'package:hayat_gp2_18/donations/publish_offer.dart';
import 'package:hayat_gp2_18/donations/published_request_cho.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:hayat_gp2_18/donations/view_offers.dart';
import 'package:hayat_gp2_18/home_pages/charity_home.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HomeC2 extends StatelessWidget {
  var Cid;

  HomeC2(
    this.Cid,
  ) : super();

  @override
  Widget build(BuildContext context) {
    var Charityid1 = Cid;
    print(Charityid1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeC(Cid)));
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
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
                          builder: (context) => publishedRequestCHO(Cid)));
                },
                splashColor: Colors.red,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('images/donationsTap.jpg',
                          width: 210, height: 150, fit: BoxFit.contain),
                      Text(
                        "\nMy Requests",
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
                      Text(
                        "\n\nSearch Donations",
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
