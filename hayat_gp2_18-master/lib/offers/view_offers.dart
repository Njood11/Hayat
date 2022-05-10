import 'package:flutter/material.dart';
//import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/offers/donation_details_d.dart';
import 'package:hayat_gp2_18/offers/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:flutter/material.dart';
//import 'package:hayat_gp2_18/database/sqlite.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/offers/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PublishedOffers extends StatefulWidget {
  PublishedOffers(this.Did);
  var Did;

  @override
  _PublishedOffersState createState() => _PublishedOffersState(this.Did);
}

class _PublishedOffersState extends State<PublishedOffers> {
  List<ParseObject> allOffers = <ParseObject>[];
  var Did;
  String offerStatus = '';
  _PublishedOffersState(this.Did);

  void getOffers(String DID) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("donor_ID", DID);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allOffers = apiResponse.results as List<ParseObject>;
      });
    } else {
      allOffers = [];
    }
  }

  Color? getDynamicColor(String status) {
    if (offerStatus == 'Requested') {
      return Colors.green[400];
    }
    if (offerStatus == 'Sent') {
      return Colors.amberAccent;
    }
    if (offerStatus == 'Delivered') {
      return Colors.blueGrey;
    } else {
      return Colors.black;
    }
  }

  @override
  void initState() {
    super.initState();
    getOffers(Did);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: allOffers.length,
            itemBuilder: (context, i) {
              var offer = allOffers[i];
              print(offer);
              /* if (offer.get('requested') == true) {
                offerStatus = 'Requested';
              }
              if (offer.get('requested') == false) {
                offerStatus = 'Sent';
              }*/
              print(offer);
              if (offer.get('req_donation_status') == 'Requested') {
                offerStatus = 'Requested';
              }
              if (offer.get('req_donation_status') == 'Sent') {
                offerStatus = 'Sent';
              }
              if (offer.get('req_donation_status') == 'Delivered') {
                offerStatus = 'Delivered';
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: Offset(3, 4))
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    print(offer.get("food_category").toString() +
                        offer.get("food_status").toString() +
                        offer.get("donor_ID").toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => offerDetailesForDonor(
                                  SelectedOfferCategory:
                                      offer.get("food_category").toString(),
                                  SelectedOfferStatus:
                                      offer.get("food_status").toString(),
                                  SelectedAvailableQuantity:
                                      offer.get("aq").toString(),
                                  SelectedExpirationDate:
                                      offer.get("exp_date").toString(),
                                  SelectedPic: offer.get<ParseFile>("pic"),
                                  SelectedDonorId:
                                      offer.get("donor_ID").toString(),
                                )));
                  },
                  title: Text(
                      '\nFood Category:${offer.get("food_category").toString()}\n\nFood Status:${offer.get("food_status").toString()}\n\nEXP:${offer.get("exp_date").toString()}'),
                  subtitle: Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.mode_standby_outlined,
                                  color: getDynamicColor(offerStatus),
                                  size: 16),
                            ),
                            TextSpan(
                                text: ' $offerStatus       \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getDynamicColor(offerStatus),
                                    fontSize: 16)),
                          ],
                        ),
                      )),
                ),
              );
            }),
      ),
    );
  }
}
