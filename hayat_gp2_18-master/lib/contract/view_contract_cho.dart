import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/donations/donation_details_d.dart';
import 'package:hayat_gp2_18/donations/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'contract_details.dart';

class PublishedContractC extends StatefulWidget {
  PublishedContractC({Key? key, this.Cid}) : super(key: key);
  var Cid;

  @override
  _PublishedcontractCState createState() => _PublishedcontractCState(this.Cid);
}

class _PublishedcontractCState extends State<PublishedContractC> {
  List<ParseObject> allcontracts = <ParseObject>[];
  var Cid;
  _PublishedcontractCState(this.Cid);

// function to retrive all contracts with the same Charity ID from database
  void getContracts(String CID) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('contracts'))
          ..whereEqualTo("cho_id", CID);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allcontracts = apiResponse.results as List<ParseObject>;
      });
    } else {
      allcontracts = [];
    }
  }

  @override
  void initState() {
    super.initState();
    getContracts(Cid);
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
            itemCount: allcontracts.length,
            itemBuilder: (context, i) {
              var contract = allcontracts[i];
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
                            builder: (context) => contractDetailesForDonor(
                                  Selectedperiod:
                                      contract.get("period").toString(),
                                  SelectedcontCategory:
                                      contract.get("Food_category").toString(),
                                  SelectedcontStatus:
                                      contract.get("Food_status").toString(),
                                  SelectedAvailableQuantity_c:
                                      contract.get("fquantity").toString(),
                                  SelectedExpirationDate_c:
                                      contract.get("End_date").toString(),
                                )));
                  },
                  /* leading:   Image.network(
                          offer.pic,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),*/
                  title: Text(
                      'Food Category:${contract.get("Food_category").toString()}\n\nFood Status:${contract.get("Food_status").toString()}\n\nEXP:${contract.get("End_date").toString()}\n\nperiod:${contract.get("period").toString()}\n '),
                  subtitle: Text('Available Quantity' +
                      contract.get("fquantity").toString()),
                ),
              );
            }),
      ),
    );
  }
}
