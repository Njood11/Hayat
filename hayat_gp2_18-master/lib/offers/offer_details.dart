/*import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';

class offerDetailes extends StatelessWidget {
  var SelectedOfferCategory;
  var SelectedOfferStatus;
  var SelectedAvailableQuantity;
  var SelectedExpirationDate;
  var SelectedPic;
  var SelectedDonorId;

  offerDetailes(
      {Key? key,
      this.SelectedOfferCategory,
      this.SelectedOfferStatus,
      this.SelectedAvailableQuantity,
      this.SelectedExpirationDate,
      this.SelectedPic,
      this.SelectedDonorId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var C = this.SelectedOfferCategory;
    var S = this.SelectedOfferStatus;
    var A = this.SelectedAvailableQuantity;
    var E = this.SelectedExpirationDate;
    var P = this.SelectedPic;
    var I = this.SelectedDonorId;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blueGrey[200],
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
              label: Text("Logout"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginAll()));
              },
            ),
          ],
        ),
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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text(
                'Donation offer details',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text('\n\n\nFood Category of the Donation: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + C,
                overflow: TextOverflow.visible,
              ),
              Text('\nFood Status of Donation: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + S,
                overflow: TextOverflow.visible,
              ),
              Text('\nAvailable Quantity (# person): ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + A,
                overflow: TextOverflow.visible,
              ),
              Text('\nExpiration date: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                '\n' + E + '\n',
                overflow: TextOverflow.visible,
              ),
              Divider(color: Colors.grey),
              Text(
                '\nDonor information',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              // Text(' '),
            ],
          ),
        ));
  }
}
*/
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/cho_home.dart';
import 'package:hayat_gp2_18/offers/search_offers.dart';
import 'package:hayat_gp2_18/signin/signin_all.dart';
import 'package:hayat_gp2_18/main.dart';
import 'package:parse_server_sdk_flutter/generated/i18n.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class offerDetailes extends StatefulWidget {
  var SelectedOfferCategory;
  var SelectedOfferStatus;
  var SelectedAvailableQuantity;
  var SelectedExpirationDate;
  var SelectedPic;
  var SelectedDonorId;
  var SelectedDonor;
  var SelectedOfferId;
  var SelectedCHOId;

  offerDetailes(
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
  _offerDetailes createState() => _offerDetailes(
      SelectedOfferCategory,
      SelectedOfferStatus,
      SelectedAvailableQuantity,
      SelectedExpirationDate,
      SelectedPic,
      SelectedDonorId,
      SelectedOfferId,
      SelectedCHOId);
}

class _offerDetailes extends State<offerDetailes> {
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

  _offerDetailes(
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

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, "OK");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeC(SelectedCHOId)),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success!"),
      content: Text(
          "Your request has been successful.\nNow you can find your request on the (Published Requests) page on your home page."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        //delete offer from search page
        //add offer in published request page
        //add offer in requested offers
        showAlertDialog2;
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue requesting this donation?"),
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text(
              'Donation offer details',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text('\n\n\nFood category of the donation: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '\n' + C,
              overflow: TextOverflow.visible,
            ),
            Text('\nFood Status of Donation: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + S,
              overflow: TextOverflow.visible,
            ),
            Text('\nAvailable quantity (# person): ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + A,
              overflow: TextOverflow.visible,
            ),
            Text('\nExpiration date: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + E + '\n',
              overflow: TextOverflow.visible,
            ),
            Divider(color: Colors.grey),
            /*  Text(
              '\nDonor information',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text('\n\n\nDonor type: ' + donor[0].get("type").toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + donor[0].get("type").toString(),
            ),
            Text('\nName: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + donor[0].get("name").toString(),
              overflow: TextOverflow.visible,
            ),
            Text('\nContact number: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + donor[0].get("phone").toString(),
              overflow: TextOverflow.visible,
            ),
            Text('\nLocation: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '' + donor[0].get("location").toString(),
              overflow: TextOverflow.visible,
            ),*/

            /*  Column(
                    children: <Widget>[
                      Text('\nLocation: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '\n' + donor[0].get("location").toString(),
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey[200]),
                  ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.teal[200]),
                  ),
                  onPressed: () async {
                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                    );
                    Widget continueButton = TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        //update request column to true (Done)
                        var RequestedOffer = ParseObject('donations')
                          ..objectId = SelectedOfferId
                          ..set('requested', true)
                          ..set('RequesterCHOid', SelectedCHOId);
                        await RequestedOffer.save();
                        //delete offer from search page (Done)
                        //add offer in published request page

                        //add offer in requested offers
                        // set up the button

                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context, "OK");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeC(SelectedCHOId)),
                            );
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Success!"),
                          content: Text(
                              "Your request has been successful.\n\nNow you can find your request on the (Published Requests) page on your home page."),
                          actions: [
                            okButton,
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
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text(""),
                      content: Text(
                          "Would you like to continue requesting this donation?"),
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
                  child: const Text('Request Donation')),
            ),
          ],
        ),
      ),
    ));
  }
}

/*  Text('\n\n\nFood category of the donation: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + C,
                    overflow: TextOverflow.visible,
                  ),
                  Text('\nFood Status of Donation: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + S,
                    overflow: TextOverflow.visible,
                  ),
                  Text('\nAvailable quantity (# person): ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + A,
                    overflow: TextOverflow.visible,
                  ),
                  Text('\nExpiration date: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + E + '\n',
                    overflow: TextOverflow.visible,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    '\nDonor information',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text('\n\n\nDonor type: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + donor[0].get("type").toString(),
                    overflow: TextOverflow.visible,
                  ),
                  Text('\nName: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + donor[0].get("name").toString(),
                    overflow: TextOverflow.visible,
                  ),
                  Text('\nContact number: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\n' + donor[0].get("phone").toString(),
                    overflow: TextOverflow.visible,
                  ), */
