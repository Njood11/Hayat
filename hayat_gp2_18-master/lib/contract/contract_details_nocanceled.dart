import 'dart:math';
import 'dart:io' as Platform;

import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

class contractDetailesnocanceled extends StatelessWidget {
  List<ParseObject> ChO = <ParseObject>[];
  var SelectedcontCategory;
  var SelectedcontStatus;
  var SelectedAvailableQuantity_c;
  var SelectedStartDate_c;
  var SelectedEndDate_c;
  var Selectedperiod;
  var SelectedContractId;
  var Did;
  var charityWeContractwith;

  contractDetailesnocanceled({
    Key? key,
    this.SelectedcontCategory,
    this.SelectedcontStatus,
    this.SelectedAvailableQuantity_c,
    this.SelectedStartDate_c,
    this.SelectedEndDate_c,
    this.Selectedperiod,
    this.SelectedContractId,
    this.Did,
    this.charityWeContractwith,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var C = this.SelectedcontCategory;
    var S = this.SelectedcontStatus;
    var A = this.SelectedAvailableQuantity_c;
    var SD = this.SelectedStartDate_c;
    var ED = this.SelectedEndDate_c;
    var P = this.Selectedperiod;
    var contractId = this.SelectedContractId;
    var Did = this.Did;
    var CID = this.charityWeContractwith;

    List<ParseObject> ChO = <ParseObject>[];

// function to retrive all contracts with same Charity ID from database
    /*void getContracts(String CID) async {
      QueryBuilder<ParseUser> queryUsers =
          QueryBuilder<ParseUser>(ParseUser.forQuery())
            ..whereEqualTo("cho_id", CID);

      final ParseResponse apiResponse = await queryUsers.query();

      if (apiResponse.success && apiResponse.results != null) {
        ChO = apiResponse.results as List<ParseObject>;
        print('cho id' + CID);
        print(ChO[0]);
        print('cho' + ChO[0].get(("name")));
      } else {
        ChO = [];
      }
    }*/

    void getDonor(String SelectedchoId) async {
      QueryBuilder<ParseUser> queryUsers =
          QueryBuilder<ParseUser>(ParseUser.forQuery())
            ..whereEqualTo("objectId", SelectedchoId);

      final ParseResponse apiResponse = await queryUsers.query();

      if (apiResponse.success) {
        ChO = apiResponse.results as List<ParseObject>;
        print('donors');
        print(ChO);
        print(ChO[0].get('name'));
        print(ChO[0].get('phone'));
      } else {
        ChO = [];
      }
    }

    openwhatsapp(phone) async {
      // var whatsapp = "+919144040888";
      print('access openwhatsapp ');
      print(phone);
      var whatsappURl_android =
          "whatsapp://send?phone=" + phone + "&text=hello";
      var whatappURL_ios = "https://wa.me/$phone?text=${Uri.parse("hello")}";

      // android
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text(
          'Hayat food donation',
        ),
        backgroundColor: Colors.teal[200],
        elevation: 0.0,
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
              'Contract details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            Text('\nPeriod : ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '\n' + P + '\n',
              overflow: TextOverflow.visible,
            ),
            Text('\nStart date: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '\n' + SD + '\n',
              overflow: TextOverflow.visible,
            ),
            Text('\nEnd date: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '\n' + ED + '\n',
              overflow: TextOverflow.visible,
            ),
            Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey[200]),
                  ),
                  onPressed: () async {
                    // set up the buttons
                    print(CID);
                    getDonor(CID);
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

                        var Userphone = ChO[0].get('phone').toString();
                        print('hey ' + ChO[0].get('phone').toString());
                        print(Userphone);
                        openwhatsapp(Userphone);
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text(
                        '\ncharity Information',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        child: Text(
                          '\nName:  ' +
                              ChO[0].get("name").toString() +
                              '\n\nContact number:  ' +
                              ChO[0].get("phone").toString() +
                              '\n\nLocation:  ' +
                              ChO[0].get("location").toString(),
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
                  child: const Text('charity Information')),
            ),
          ],
        ),
      ),
    );
  }
}