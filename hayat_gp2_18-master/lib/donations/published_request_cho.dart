import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/charity_home.dart';
import 'package:hayat_gp2_18/donations/Req_offer_info.dart';
import 'package:hayat_gp2_18/donations/offer_details.dart';
import 'package:hayat_gp2_18/home_pages/charity_home_2.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class publishedRequestCHO extends StatefulWidget {
  var Cid;
  publishedRequestCHO(this.Cid) : super();

  @override
  _publishedRequestCHO createState() => _publishedRequestCHO(Cid);
}

class _publishedRequestCHO extends State<publishedRequestCHO> {
  List<ParseObject> allOffers = <ParseObject>[];

  var Cid;
  var offerStatus = '';
  _publishedRequestCHO(this.Cid);

  void initState() {
    super.initState();

    getRequestedOffers(Cid);
  }

  Color? getDynamicColor(String status) {
    if (status == 'Delivered') {
      return Colors.blueGrey;
    } else {
      return Colors.teal[200];
    }
  }

  String getDynamicText(String status) {
    if (status == 'Delivered') {
      return 'Completed';
    } else {
      return 'I collect this donation';
    }
  }

  void getRequestedOffers(String Cid) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('donations'))
          ..whereEqualTo("RequesterCHOid", Cid);

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
  Widget build(BuildContext context) {
    print('Cid in Requested Offers');

    print(Cid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeC2(Cid)));
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.teal[200],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: allOffers.length,
                      itemBuilder: (context, i) {
                        var offer = allOffers[i];
                        print(offer);

                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(13),
                            /* boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(3, 4))
                            ],*/
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReqOfferInfo(
                                          SelectedOfferCategory: offer
                                              .get("food_category")
                                              .toString(),
                                          SelectedOfferStatus: offer
                                              .get("food_status")
                                              .toString(),
                                          SelectedAvailableQuantity:
                                              offer.get("aq").toString(),
                                          SelectedExpirationDate:
                                              offer.get("exp_date").toString(),
                                          SelectedPic:
                                              offer.get<ParseFile>("pic"),
                                          SelectedDonorId:
                                              offer.get("donor_ID").toString(),
                                          SelectedOfferId:
                                              offer.get("objectId").toString(),
                                          SelectedCHOId: Cid)));
                            },
                            title: Text(
                                '\nFood Category:${offer.get("food_category").toString()}\n\nFood Status:${offer.get("food_status").toString()}\n'),
                            subtitle: Column(children: <Widget>[
                              Text(
                                'EXP: ' + offer.get("exp_date").toString(),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              ElevatedButton(
                                child: Text(getDynamicText(
                                    offer.get('req_donation_status'))),
                                onPressed: () async {
                                  var RequestedOffer = ParseObject('donations')
                                    ..objectId = offer.get("objectId")
                                    ..set('req_donation_status', 'Delivered');
                                  await RequestedOffer.save();
                                  if (offer.get('req_donation_status') ==
                                      'Requested') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                publishedRequestCHO(Cid)));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      getDynamicColor(
                                          offer.get('req_donation_status'))),
                                ),
                              ),
                            ]),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
