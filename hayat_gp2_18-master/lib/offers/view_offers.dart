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
  PublishedOffers({Key? key, this.Did}) : super(key: key);
  var Did;

  @override
  _PublishedOffersState createState() => _PublishedOffersState(this.Did);
}

class _PublishedOffersState extends State<PublishedOffers> {
  List<ParseObject> allOffers = <ParseObject>[];
  var Did;
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
                                  SelectedPic: offer.get("pic").toString(),
                                  SelectedDonorId:
                                      offer.get("donor_ID").toString(),
                                )));
                  },
                  /* leading:   Image.network(
                          offer.pic,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),*/
                  title: Text(
                      'Food Category:${offer.get("food_category").toString()}\n\nFood Status:${offer.get("food_status").toString()}\n\nEXP:${offer.get("exp_date").toString()}\n'),
                  subtitle:
                      Text('Available Quantity' + offer.get("aq").toString()),
                ),
              );
            }),
      ),
    );
  }
}
