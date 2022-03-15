import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ReqOfferInfo extends StatefulWidget {
  var SelectedOfferCategory;
  var SelectedOfferStatus;
  var SelectedAvailableQuantity;
  var SelectedExpirationDate;
  var SelectedPic;
  var SelectedDonorId;
  var SelectedDonor;
  var SelectedOfferId;
  var SelectedCHOId;

  ReqOfferInfo(
      {Key? key,
      this.SelectedOfferCategory,
      this.SelectedOfferStatus,
      this.SelectedAvailableQuantity,
      this.SelectedExpirationDate,
      this.SelectedPic,
      this.SelectedDonorId,
      this.SelectedOfferId,
      this.SelectedCHOId})
      : super(key: key);
  @override
  _ReqOfferInfo createState() => _ReqOfferInfo(
      SelectedOfferCategory,
      SelectedOfferStatus,
      SelectedAvailableQuantity,
      SelectedExpirationDate,
      SelectedPic,
      SelectedDonorId,
      SelectedOfferId,
      SelectedCHOId);
}

class _ReqOfferInfo extends State<ReqOfferInfo> {
  List<ParseObject> donor = <ParseObject>[];
  var nameOfDonor;
  var SelectedOfferCategory;
  var SelectedOfferStatus;
  var SelectedAvailableQuantity;
  var SelectedExpirationDate;
  var SelectedPic;
  var SelectedDonorId;
  var SelectedDonor;
  var SelectedOfferId;
  var SelectedCHOId;

  _ReqOfferInfo(
      this.SelectedOfferCategory,
      this.SelectedOfferStatus,
      this.SelectedAvailableQuantity,
      this.SelectedExpirationDate,
      this.SelectedPic,
      this.SelectedDonorId,
      this.SelectedOfferId,
      this.SelectedCHOId);

  @override
  void initState() {
    super.initState();

    getDonor(SelectedDonorId);
  }

  void getDonor(String SelectedDonorId) async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery())
          ..whereEqualTo("objectId", SelectedDonorId);

    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success) {
      setState(() {
        donor = apiResponse.results as List<ParseObject>;
        print('donors');
        print(donor);
        print(donor[0].get('name'));
        print(donor[0].get('phone'));
        print(donor[0].get('type'));

        // location = donor[0].get("location").toString();
      });
    } else {
      donor = [];
    }
  }

  Widget build(BuildContext context) {
    var SelectedOfferCategory;
    var SelectedOfferStatus;
    var SelectedAvailableQuantity;
    var SelectedExpirationDate;
    var SelectedPic;
    var SelectedDonorId;
    var SelectedDonor;
    var C = this.SelectedOfferCategory;
    var S = this.SelectedOfferStatus;
    var A = this.SelectedAvailableQuantity;
    var E = this.SelectedExpirationDate;
    var P = this.SelectedPic;
    var I = this.SelectedDonorId;
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[200],
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                ),
            color: Colors.white70,
          ),
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '\nDonation offer details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          '\nFood category of the donation: \n',
                          overflow: TextOverflow.visible,
                        ),
                        subtitle: Text(C),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          '\nFood Status of Donation: \n',
                          overflow: TextOverflow.visible,
                        ),
                        subtitle: Text(S),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          '\nAvailable quantity (# person): \n',
                          overflow: TextOverflow.visible,
                        ),
                        subtitle: Text(A),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          '\nExpiration date: : \n',
                          overflow: TextOverflow.visible,
                        ),
                        subtitle: Text(E),
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                          onPressed: () async {
                            // set up the buttons
                            Widget cancelButton = TextButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                              },
                            );
                            Widget continueButton = TextButton(
                              child: Text("Contact"),
                              onPressed: () {
                                //what's app
                              },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text(
                                '\nDonor Information',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              content: Container(
                                child: Text(
                                  '\nDonor type:  ' +
                                      donor[0].get("type").toString() +
                                      '\n\nName:  ' +
                                      donor[0].get("name").toString() +
                                      '\n\nContact number:  ' +
                                      donor[0].get("phone").toString() +
                                      '\n\nLocation:  ' +
                                      donor[0].get("location").toString(),
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          child: const Text('Donor Information')),
                    ),
                    /*   Container(
                      child: ListTile(
                        title: Text(
                          '\nDonor Information',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                   \Container(
                      child: ListTile(
                        title: Text(
                          '\nDonor type:  ' +
                              donor[0].get("type").toString() +
                              '\nName:  ' +
                              donor[0].get("name").toString() +
                              '\nContact number:  ' +
                              donor[0].get("phone").toString() +
                              '\nLocation:  ' +
                              donor[0].get("location").toString(),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ])),
    ));
  }
}
