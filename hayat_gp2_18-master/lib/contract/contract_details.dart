import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/donations/search_offers.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class contractDetailesForDonor extends StatelessWidget {
  var SelectedcontCategory;
  var SelectedcontStatus;
  var SelectedAvailableQuantity_c;
  var SelectedStartDate_c;
  var SelectedEndDate_c;
  var Selectedperiod;
  var SelectedContractId;
  var Did;
  var charityWeContractwith;

  contractDetailesForDonor({
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
    void getContracts(String CID) async {
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
                        var CancelContract = ParseObject('contracts')
                          ..objectId = contractId
                          ..set('contract_status', "Canceled");

                        await CancelContract.save();

                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context, "OK");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeD(Did)),
                            );
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Canceled!"),
                          content: Text("your contract with\n"),
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
                      content: Text("Would you like to Cancel this contract?"),
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
                  child: const Text('Cancel')),
            ),
          ],
        ),
      ),
    );
  }
}
