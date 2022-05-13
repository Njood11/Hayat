import 'package:flutter/material.dart';
import 'package:hayat_gp2_18/home_pages/donor_home.dart';
import 'package:hayat_gp2_18/donations/donation_details_d.dart';
import 'package:hayat_gp2_18/donations/offer_details.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'contract_details.dart';

class PublishedContract extends StatefulWidget {
  PublishedContract(this.Did);
  var Did;
  @override
  _PublishedcontractState createState() => _PublishedcontractState(this.Did);
}

class _PublishedcontractState extends State<PublishedContract> {
  List<ParseObject> allcontracts = <ParseObject>[];
  var Did;
  String offercontract = '';

  _PublishedcontractState(this.Did);

  var CharityWeContractWith;

// function to retrive all contracts with the same Donor ID from database
  void getContracts(String DID) async {
    QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('contracts'))
          ..whereEqualTo("donor_id", DID);

    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        allcontracts = apiResponse.results as List<ParseObject>;
      });
    } else {
      allcontracts = [];
    }
  }

  Color? getDynamicColor(String status) {
    if (offercontract == 'Valid') {
      return Colors.green[400];
    } else {
      return Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    getContracts(Did);
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
              var offer = allcontracts[i];

              if (offer.get('canceled') == true) {
                offercontract = 'Cancel';
              }
              if (offer.get('canceled') == false) {
                offercontract = 'Valid';
              }
              var contract = allcontracts[i];

              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                                      contract.get("contract_type").toString(),
                                  SelectedcontCategory:
                                      contract.get("Food_category").toString(),
                                  SelectedcontStatus:
                                      contract.get("Food_status").toString(),
                                  SelectedAvailableQuantity_c:
                                      contract.get("fquantity").toString(),
                                  SelectedExpirationDate_c:
                                      contract.get("End_date").toString(),
                                  SelectedContractId:
                                      contract.get("objectId").toString(),
                                  charityWeContractwith:
                                      contract.get("cho_id").toString(),
                                )));
                  },
                  /* leading:   Image.network(
                          offer.pic,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),*/
                  title: Text(
                      '\nFood Category:${contract.get("Food_category").toString()}\n\nFood Status:${contract.get("Food_status").toString()}\n\nAvailable Quantity:${contract.get("fquantity").toString()}\n\nperiod:${contract.get("contract_type").toString()}\n\nEXP:${contract.get("End_date").toString()}'),
                  subtitle: Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.mode_standby_outlined,
                                  color: getDynamicColor(offercontract),
                                  size: 16),
                            ),
                            TextSpan(
                                text: ' $offercontract       \n',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getDynamicColor(offercontract),
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
